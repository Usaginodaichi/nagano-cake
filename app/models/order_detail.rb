class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status:{production_not_allowed:0, waiting:1, production:2, completed:3}

  def subtotal
    price * amount
  end
end
