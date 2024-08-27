class Public::HomesController < ApplicationController
  before_action :authenticate_user!, except: [:top]

  def top
    @new_item = Item.order(created_at: :desc).limit(4)
  end

  def about
  end
end
