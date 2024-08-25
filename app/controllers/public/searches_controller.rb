class Public::SearchesController < ApplicationController
  def index
    @results = Item.where("name LIKE ?", "%#{params[:q]}%")
  end
end
