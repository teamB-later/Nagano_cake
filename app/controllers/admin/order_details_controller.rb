class Admin::OrderDetailsController < ApplicationController
  def update
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_making_status_params)
      redirect_to admin_order_path(@order)
    else
      render :show
    end
  end
  
  private
  def order_detail_making_status_params
    params.require(:order_detail).permit(:making_status)
  end
end