class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method:{credit_card:0, transfer:1}
  enum status:{waiting:0, confirmation:1, production:2, shipping_preparation:3, sent:4}

  validates :name, presence: true
  validates :postal_code, {numericality: {only_integer: true}, length: {is: 7}}
  validates :address, presence: true
  validates :shipping_cost, {presence: true, numericality: {only_integer: true}}
  validates :total_payment, {presence: true, numericality: {only_integer: true}}
  validates :payment_method, {presence: true, numericality: {only_integer: true}}
  validates :status, {presence: true, numericality: {only_integer: true}}




  def sum_of_order_price
    total_payment + shipping_cost
  end
end
