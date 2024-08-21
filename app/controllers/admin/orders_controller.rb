class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @status = Order.statuses
  end

  def update
    @order = Order.find(params[:id])
    @status = Order.statuses
  end
end
