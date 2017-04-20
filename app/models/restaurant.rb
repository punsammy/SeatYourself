class Restaurant < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :users, through: :reservations
  belongs_to :owner, class_name: "User"

  @@counter = 1

  def self.auto_generate
    r = create(name: "Fake-#{@@counter}", address: "#{rand(1000)} Fake St.",
               description: "This is a fake restaurant!", capacity: 100, user_id: 0)
    @@counter += 1
  end

end
