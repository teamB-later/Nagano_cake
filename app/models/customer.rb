class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーション
  validates :last_name, presence: true, length: {in: 1..30}
  validates :first_name, presence: true, length: {in: 1..30}
  validates :last_name_kana, presence: true, length: {in: 1..30}
  validates :first_name_kana, presence: true, length: {in: 1..30}
  validates :post_code, presence: true, numericality: { only_integer: true }, length: { is: 7 }
  validates :address, presence: true, length: {in: 1..100}
  validates :telephone_number, presence: true, numericality: { only_integer: true }, length: { in: 10..11 }

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
