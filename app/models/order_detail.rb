class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  # enum
  enum making_status: { impossible: 0, wating: 1, making: 2, finish: 3 }
  
end
