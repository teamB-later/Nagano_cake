class Public::CustomersController < ApplicationController
  def show
    @customer_id = current_customer.id
    @customer = Customer.find(@customer_id)

  end

  def edit
    @customer_id = current_customer.id
    @customer = Customer.find(@customer_id)
  end

  def update
    @customer_id = current_customer.id
    @customer = Customer.find(@customer_id)
    if @customer.update(customer_params)
      redirect_to customers_path

    end
  end

  def unsubscribe
  end

  def withdraw

  end
end

private
def customer_params
  params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :post_code, :address, :telephone_number, :email)
end