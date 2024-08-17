class Order < ApplicationRecord
  belongs_to :customer
  # items
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details
end
