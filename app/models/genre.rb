class Genre < ApplicationRecord
  
  validates :name, presence: true, length: {in: 1..30}
  
  has_many :items
  
end
