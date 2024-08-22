class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
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
  end

  def index
  end

  def show
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
    params.require(:order).permit(:post_code, :address, :name, :payment_method)
  end

  def select_address_params
    params[:order][:select_address]
  end

  def address_params
    params[:order][:address_id]
  end

end
