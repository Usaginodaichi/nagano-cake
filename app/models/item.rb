class Item < ApplicationRecord
  belongs_to :genre, dependent: :destroy
  has_one_attached :image
end
