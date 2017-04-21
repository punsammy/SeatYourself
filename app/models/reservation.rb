class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  # Replace these later with Restaurant#min_hour etc.
  @@min_hour = 11
  @@max_hour = 19
  @@min_notice = 30 * 60 # 30 minutes

  def self.next_possible_time
    t = Time.now
    if t.hour < @@min_hour
      # next possible reservation at opening time
      Time.mktime(t.year, t.month, t.day, @@min_hour)
    elsif t.hour > @@max_hour - 1
      # opening time the next day
      t += 24 * 3600 # next day
      Time.mktime(t.year, t.month, t.day, @@min_hour)
    else
      # next hour
      Time.mktime(t.year, t.month, t.day, t.hour + 1)
    end

  end

end
