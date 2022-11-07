class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status:{production_not_allowed:0, waiting:1, production:2, completed:3}

  validates :price, {presence: true, numericality: {only_integer: true}}
  validates :amount, {presence: true, numericality: {only_integer: true}}
  validates :making_status, {presence: true, numericality: {only_integer: true}}

  def subtotal
    price * amount
  end
end
