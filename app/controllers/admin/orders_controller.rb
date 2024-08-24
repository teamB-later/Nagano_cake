class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @status = Order.statuses
    @order_details = @order.order_details

  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  # 　order_detail = id
    # order_detail = @order.order_id

    if order_confirmation == true
      @order_details.each do |order_detail|
        order_detail.update(making_status: "waiting")
      end
    end

    if @order.update(order_params)
      redirect_to admin_order_path(@order)
    else
      render :show
    end

  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

  def order_confirmation
      if @order.status != 'confirmation'
        return false
      else
        return true
      end
  end

end