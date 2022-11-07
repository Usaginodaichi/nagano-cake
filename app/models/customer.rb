class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true, format:{with: VALID_EMAIL_REGEX}, uniqueness:{case_sensitive: false}}
  validates :encrypted_password, {presence: true, length:{minimum: 6}}
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, {presence: true, numericality: {only_integer: true}}
  validates :is_deleted, inclusion: {in:[true, false]}

  def active_for_authentication?
    super && (is_deleted == false)
  end

  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
end
