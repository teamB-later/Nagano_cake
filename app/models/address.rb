class Address < ApplicationRecord

  validates :name, presence: true, length: {in: 1..30}
  validates :post_code, presence: true, numericality: { only_integer: true }, length: { is: 7 }
  validates :address,length: {in: 1..100}

  belongs_to :customer

  def address_display
    '〒' + post_code + ' ' + address + ' ' + name
  end
end