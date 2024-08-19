class Item < ApplicationRecord
  belongs_to :genre
  # customers
  has_many :cart_items, dependent: :destroy
  has_many :customers, through: :cart_items
  # orders
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details
end
