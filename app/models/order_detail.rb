class OrderDetail < ApplicationRecord
  belongs_to :order, dependent: :destory
  belongs_to :item, dependent: :destory

  def subtotal
    price * amount
  end
end
