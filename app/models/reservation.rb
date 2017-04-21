class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  # has_many :reservations, through: :restaurant
  validates :restaurant_id, :time, :party_size, presence: true
  validates :party_size, numericality: { only_integer: true, greater_than: 0 }
  validate :time_slot_available

  scope :overlap, ->(time) { where(time: time) }

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

  def seats_available
    restaurant.capacity - restaurant.reservations.overlap(time).sum(:party_size)
  end

  def time_slot_available
    return unless restaurant
    return unless time
    if time < opening_time
      errors.add(:time, "is before opening time.")
    elsif time > (closing_time - 3600)
      erros.add(:time, "is less than an hour before closing time.")
    elsif time.min != 0
      # Remove this constraint later
      errors.add(:time, "must be on the hour.")
    else
      # Sanitize the time to remove seconds:
      time = Time.mktime(time.year, time.month, time.day, time.hour)
      if time - Time.now < (minutes_notice * 60)
        errors.add(:time, "is too soon. Please provide at least #{minutes_notice} minutes notice")
      end
    end
    return unless party_size
    if party_size > seats_available
      errors.add(:time, "is not available for a party of your size. Please try another time.")
    end
  end

  def opening_time
    Time.mktime(time.year, time.month, time.day, restaurant.opening.hour)
  end

  def closing_time
    Time.mktime(time.year, time.month, time.day, restaurant.closing.hour)
  end

end
