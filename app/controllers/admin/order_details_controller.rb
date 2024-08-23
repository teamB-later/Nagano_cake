class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_id = @order_detail.order_id
    @order = Order.find(@order_id)

    if @order_detail.making_status == "making"
      @order.update(status:"making")
    end

    if @order_detail.update(order_detail_making_status_params)
      redirect_to admin_order_path(@order)
    else
      render :show
    end




    # case OrderDetail.making_statuses.key("製作中")
    #   when 2
    #     @order.statuses.key = 2
    # end

  end

  private
  def order_detail_making_status_params
    params.require(:order_detail).permit(:making_status)
  end


end