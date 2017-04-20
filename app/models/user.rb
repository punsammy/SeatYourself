class User < ApplicationRecord
  has_many :restaurants, through: :reservations
  has_many :owned_restaurants, class_name: "User"
end
