class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = current_customer.addresses.all
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to addresses_path#, notice: '住所が追加されました。'
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path#, notice: '住所が更新されました。'
  end

  def destroy
     @address = Address.find(params[:id])
     @address.destroy
     redirect_to addresses_path#, notice: '住所が削除されました。'
  end

  private

  def address_params
    params.require(:address).permit(:post_code, :address, :name)
  end

end
