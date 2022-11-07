class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  validates :amount, {presence: true, numericality: {only_integer: true}}

  def subtotal
    item.with_tax_price * amount
  end


end
