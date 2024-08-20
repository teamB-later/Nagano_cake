class Public::CartItemsController < ApplicationController
  def index
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  def destroy_all
    
  end
  
  def create
    
  end
  
  private
  
  def cart_item_params
    params.requier(:cart_item).permit(:item_id, :amount)
  end 
end
