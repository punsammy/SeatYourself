class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  # has_many :reservations, through: :restaurant

  validates :restaurant_id, :time, :party_size, presence: true
  validates :party_size, numericality: { only_integer: true, greater_than: 0 }
  validate :restaurant_open
  validate :time_slot_rounded
  validate :enough_notice
  validate :time_slot_available

  scope :overlap, ->(time) { where(time: time) }

  def self.next_possible_time
    # Returns the next available reservation time based on the current time.
    # Use this method to pre-populate the form.
    t = Time.now
    # Without a restaurant already selected, set the default hours
    min_hour = Restaurant.default_opening_time.hour
    max_hour = Restaurant.default_closing_time.hour
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

  def opening_time
    # converts opening time of restaurant into a time today
    # this should be moved to restaurant model
    opening_hour = restaurant.opening_time.hour
    Time.mktime(time.year, time.month, time.day, opening_hour)
  end

  def closing_time
    closing_hour = restaurant.closing_time.hour
    Time.mktime(time.year, time.month, time.day, closing_hour)
  end

# Custom Validation Methods:

  def restaurant_open
    # guard statements necessary to prevent crashes when no
    # data is submitted into the form.
    return unless restaurant
    return unless time
    if time < opening_time
      errors.add(:time, "is before opening time.")
    elsif time > (closing_time - restaurant.reservation_length)
      errors.add(:time, "is less than an hour before closing time.")
    end
  end

  def time_slot_rounded
    # this method checks if the time slot is rounded appropriately
    # the default is to round to the nearest hour.
    minute_values = [0] # add in others eg: [0, 15, 30, 45]
    value = "hour"
    return unless restaurant
    return unless time
    rounded_time = Time.mktime(time.year, time.month, time.day, time.hour)
    if minute_values.include?(time.min)
      errors.add(:time, "must be rounded to the nearest #{value}.")
    else
      # Sanitize the time to remove seconds:
      rounded_time = Time.mktime(time.year, time.month, time.day, time.hour, time.min)
      errors.add(:time, "must be rounded to the nearest #{value}.")
    end
  end

  def time_slot_available
    return unless restaurant
    return unless time
    return unless party_size
    if party_size > seats_available
      errors.add(:time, "is not available for a party of your size. Please try another time.")
    end
  end

  def enough_notice
    return unless restaurant
    return unless time
    if time - Time.now < (restaurant.minutes_notice * 60)
      errors.add(:time, "is too soon. Please provide at least #{restaurant.minutes_notice} minutes notice")
    end
  end

end
