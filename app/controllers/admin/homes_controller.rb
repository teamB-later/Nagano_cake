class Admin::HomesController < ApplicationController
  
  
  def top
    @orders = Order.includes(:customer).order(created_at: :desc).limit(10)
  end
  
end
