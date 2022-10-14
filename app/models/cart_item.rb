class CartItem < ApplicationRecord
  belongs_to :customer, dependent: :destroy
  belongs_to :item, dependent: :destroy

  def subtotal
    item.with_tax_price * amount
  end


end
