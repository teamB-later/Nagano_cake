class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @status = Order.statuses
    @order_detail = OrderDetail.find(params[:id])
    @order_details = OrderDetail.all
  end

  def update
     @order = Order.find(params[:id])

    # if OrderDetail.making_statuses.key("製作中")
    #   @order.statuses.key = "製作中"
    # end
    
    

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

end