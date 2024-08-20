class Item < ApplicationRecord
  belongs_to :genre
  # customers
  has_many :cart_items, dependent: :destroy
  has_many :customers, through: :cart_items
  # orders
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details
  # 画像の登録
  has_one_attached :item_image
  # 画像の表示
  def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    item_image.variant(resize_to_limit: [width, height]).processed
  end
  # 税込価格
  def with_tax_price
    (price * 1.1).floor
  end
  # 販売ステータス
  def item_status
    if is_active
      "販売中"
    else
      "販売停止中"
    end
  end
end
