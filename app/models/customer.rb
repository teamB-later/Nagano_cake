class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  # items
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items
  
  def customer_status
    if is_active
      "有効"
    else
      "退会"
    end 
  end 
end
