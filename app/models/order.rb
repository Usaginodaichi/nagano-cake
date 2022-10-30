class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method:{credit_card:0, transfer:1}
  enum status:{waiting:0, confirmation:1, production:2, shipping_preparation:3, sent:4}


  def sum_of_order_price
    total_payment + shipping_cost
  end
end
