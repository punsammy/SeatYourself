class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :reservations, through: :restaurant

  # Replace these later with Restaurant#min_hour etc.
  def self.next_possible_time
    t = Time.now
    min_hour = Restaurant.opening.hour
    max_hour = Restaurant.closing.hour
    if t.hour < min_hour
      # next possible reservation at opening time
      Time.mktime(t.year, t.month, t.day, min_hour)
    elsif t.hour > max_hour - 1
      # opening time the next day
      t += 24 * 3600 # next day
      Time.mktime(t.year, t.month, t.day, min_hour)
    else
      # next hour
      t += 3600
      Time.mktime(t.year, t.month, t.day, t.hour)
    end
  end

end
