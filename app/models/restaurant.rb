class Restaurant < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :users, through: :reservations
  belongs_to :owner, class_name: "User"
  has_many :reservations

  @@counter = 1

  # Methods for getting restaurant opening / closing times:
  # Currently returns default values.
  # Change to instance methods once they are different per restaurant.
  def self.opening(t = Time.now)
    Time.mktime(t.year, t.month, t.day, 11) # default opening at 11am
  end

  def self.closing(t = Time.now)
    Time.mktime(t.year, t.month, t.day, 20) # default closing at 8pm
  end

  def minutes_notice
    # Provide a customizable minimum notice
    30 # 30 minutes notice required
  end
  def opening(t = Time.now)
    Time.mktime(t.year, t.month, t.day, 11) # default opening at 11am
  end

  def closing(t = Time.now)
    Time.mktime(t.year, t.month, t.day, 20) # default closing at 8pm
  end

  def self.auto_generate
    r = create(name: "Fake-#{@@counter}", address: "#{rand(1000)} Fake St.",
               description: "This is a fake restaurant!", capacity: 100, user_id: 0)
    @@counter += 1
  end

end
