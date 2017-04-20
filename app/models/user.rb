class User < ApplicationRecord
  has_many :restaurants through :reservations
end
