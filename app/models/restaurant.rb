class Restaurant < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :users, through: :reservations
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_many :reservations

  @@counter = 1

  # Methods for getting restaurant opening / closing times:
  # Currently returns default values.
  # Change to instance methods once they are different per restaurant.
  def self.default_opening_time(t = Time.now)
    # This method takes a time as an argument. If none is given, it uses the
    # current time.
    # It returns the time on that day that the restaurant opens.
    Time.mktime(t.year, t.month, t.day, 11) # default opening at 11am
  end

  def self.default_closing_time(t = Time.now)
    # See description for default_opening_time
    Time.mktime(t.year, t.month, t.day, 20) # default closing at 8pm
  end

  def reservation_length
    # This will let us change the default reservation length later.
    3600 # 1 hour reservation
  end

  def minutes_notice
    # Provide a customizable minimum notice
    # Later, this can be moved to the database
    30 # 30 minutes notice required
  end

  def self.auto_generate
    # Use this method to create a restaurant object with all the fields filled in.
    r = create(name: "Fake-#{@@counter}", address: "#{rand(1000)} Fake St.",
               description: "This is a fake restaurant!", capacity: rand(100), user_id: 0,
               phone_number: "(416)-555-#{rand(1000..10000)}", opening_time: default_opening_time,
               closing_time: default_closing_time, special: "")
    @@counter += 1
  end

end
