class Admin::SearchesController < ApplicationController
  def index
    @results = Customer.where("name LIKE ?", "%#{params[:q]}%")
  end
end
