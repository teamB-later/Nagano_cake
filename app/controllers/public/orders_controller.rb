class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    order_data = order_data_params
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:address, :name, )
  end

  def order_data_params
    params[:order][:order_data]
  end
end
