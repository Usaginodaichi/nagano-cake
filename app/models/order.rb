class Order < ApplicationRecord
  belongs_to :customer, dependent: :destroy
  has_many :order_details, dependent: :destory

  enum payment_method:{credit_card:0, transfer:1}

  def sum_of_order_price
    total_payment + shipping_cost
  end
end
