class Order < ApplicationRecord
  belongs_to :customer
  # items
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details

  # emun
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting: 0, confirmation: 1, making: 2, preparation: 3, transported: 4 }
end
