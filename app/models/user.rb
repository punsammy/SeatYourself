class User < ApplicationRecord
  has_many :restaurants, through: :reservations
  has_many :owned_restaurants, class_name: "User"

  validates :name, presence: true
  validates :email, presence: true
  validates :password_digest, presence: true
  validates :postal_code, presence: true

  has_secure_password
end
