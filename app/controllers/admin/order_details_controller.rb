class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_id = @order_detail.order_id
    @order = Order.find(@order_id)
    
    order = @order_detail.order
    
    if @order_detail.update(order_detail_making_status_params)
      if @order_detail.making_status == "making"
        @order.update(status:"making")
      end
      if all_order_details_making_finished(order)
        order.update(status: "preparation")
      end
      redirect_to admin_order_path(@order)
    else
      render :show
    end

    
    
    

  end

  private
  
  def order_detail_making_status_params
    params.require(:order_detail).permit(:making_status)
  end
  
  def all_order_details_making_finished(order)
    order.order_details.each do |order_detail|
      if order_detail.making_status != "finish"
        return false
      end
    end
    return true
  end


end