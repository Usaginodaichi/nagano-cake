class Item < ApplicationRecord
  belongs_to :genre, dependent: :destroy
  # has_many :order_details, dependent: :destory


  validates :image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  # enum is_active:{sale:0, discontinued:1}
  has_one_attached :image

  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_500.jpg')
      image.attach(io:File.open(file_path),filename:'default-image.jpg',content_type:'image/jpeg')
    end
    image.variant(resize_to_limit:[width,height]).processed
  end

end
