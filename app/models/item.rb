class Item < ApplicationRecord
  belongs_to :genre, dependent: :destroy
  has_one_attached :image

  validates :image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  # enum is_active:{sale:0, discontinued:1}


def get_image(width, height)
  image.variant(resize_to_limit:[width,height]).processed
end
end
