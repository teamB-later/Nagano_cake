class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
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


    o_d_tes_meth
    redirect_to thanks_path
  end

  def o_d_tes_meth
    cart_items_params = params[:cart_items]
    puts "cart_items_params: #{cart_items_params.inspect}"
    cart_items_params.each do |key, value|
      @order_detail.order_id = @order.id
      @order_detail = @order.order_details.new
      @order_detail.item_id = value["o_d_item_id"]
      @order_detail = value["o_d_price"]
      @order_detail = value["o_d_amount"]
    end
  end

  def o_d_test
    order_detail_params_test.each do |o_d_params|
      @order_detail = @order.order_details.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = o_d_params[:o_d_item_id]
      @order_detail.price = o_d_params[:o_d_price]
      @order_detail.amount = o_d_params[:o_d_amount]
      @order_detail.save
    end
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  # メソッドの記述
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
    params.require(:order).permit(:cart_items, o_d_items: [:o_d_item_id, :o_d_price, :o_d_amount])
  end

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :amount)
  end

end
