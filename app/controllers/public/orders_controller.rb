class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :cart_items_present, except: [:index, :show, :thanks]

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    not_selected_or_not_entered_method #入力内容の不備を確認するメソッド
    customer_curt_items = current_customer.cart_items
    @cart_items = customer_curt_items.all

    @order.shipping_cost = 800 #送料800円の入力
    items_total_payment_method #商品合計の計算のメソッド
    @order.total_payment = @order.shipping_cost + @items_total_payment #請求額合計の計算

    input_address_method #ラジオボタンで選んだ住所関連の入力のメソッド
  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    order_details_method
    current_customer.cart_items.destroy_all
    redirect_to thanks_path
  end


  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end


  private

  def order_params
    params.require(:order).permit(:post_code, :address, :name, :shipping_cost, :total_payment, :payment_method)
  end

  def select_address_params
    params[:order][:select_address]
  end

  def address_params
    params[:order][:address_id]
  end

  def order_detail_params_test
    params[:order][:cart_items]
  end

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :amount)
  end

  # メソッドの記述
  def cart_items_present #カートアイテムが存在しないか確認するメソッド
    redirect_to items_path unless current_customer.cart_items.present?
  end

  def order_details_method #order_detailsを1つずつ登録するメソッド
    cart_items_params = order_detail_params_test
    cart_items_params.each do |a, b| #cart_itemsを1つずつ処理するためのeach
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      b.each do |c, d| #cart_itemが持つカラムそれぞれにデータを入れるためのeach
        if c == "o_d_item_id"
          @order_detail.item_id = d
        elsif c == "o_d_price"
          @order_detail.price = d
        else #o_d_amount
          @order_detail.amount = d
        end
      end
      @order_detail.save
    end
  end

  def not_selected_or_not_entered_method #入力情報の不備を確認
    #payment_methodとselect_address両方ともnil
    if @order.payment_method.nil? && select_address_params.nil?
      redirect_to new_order_path, alert: "支払い方法とお届け先を選択して下さい" and return
    #支払方法が未選択だった場合の処理
    elsif @order.payment_method.nil?
      redirect_to new_order_path, alert: "支払い方法を選択してください" and return
    #お届け先が未選択だった時の処理
    elsif select_address_params.nil?
      redirect_to new_order_path, alert: "お届け先を選択してください" and return
    #新しい住所を選んだときに未入力があった時の処理
    elsif (select_address_params == "2") && ((@order.post_code == "") || (@order.address == "") || (@order.name == ""))
      not_entered_address_alert_method #未入力時のメソッド
    end
  end

  def not_entered_address_alert_method #新しいお届け先が未入力だった時の処理
    if @order.post_code == ""
      if @order.address == ""
        if @order.name == ""
          redirect_to new_order_path, alert: "郵便番号と住所と宛名を入力してください" and return
        end
        redirect_to new_order_path, alert: "郵便番号と住所を入力してください" and return
      end
      if @order.name == ""
        redirect_to new_order_path, alert: "郵便番号と宛名を入力してください" and return
      end
      redirect_to new_order_path, alert: "郵便番号を入力してください" and return
    end
    if @order.address == ""
      if @order.name == ""
        redirect_to new_order_path, alert: "住所と宛名を入力してください" and return
      end
      redirect_to new_order_path, alert: "住所を入力してください" and return
    end
    if @order.name == ""
      redirect_to new_order_path, alert: "宛名を入力してください" and return
    end
  end

  def input_address_method #ラジオボタンで選んだ住所関連の入力
    select_address = select_address_params.to_i
    if select_address == 0 #current_customerの住所
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif select_address == 1 #customer.addressの住所
      @address = Address.find(address_params)
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name
    else #新規登録住所
    end
  end

  def items_total_payment_method #商品合計の計算
    @items_total_payment = 0 #商品合計の初期値を0に設定
    @cart_items.each do |cart_item|
      @items_total_payment += cart_item.subtotal
    end
  end

end
