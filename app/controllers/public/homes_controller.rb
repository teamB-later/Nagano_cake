class Public::HomesController < ApplicationController
  def top
    @new_item = Item.order(created_at: :desc).limit(4)
  end

  def about
  end
end
