class ReservationsController < ApplicationController

  def show
    @reservation = Reservation.find(params[:id])
    # if @reservation.user == current_user
    #
    # else
    #
    # end
  end

  def new
    @reservation = Reservation.new
    # These should eventually be instance methods
    @min_hour = Restaurant.opening.hour
    @max_hour = Restaurant.closing.hour - 1
    # min_notice = 30 * 60 # 30 minutes

    def next_possible_time
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
    @restaurant_list = Restaurant.all.map do |restaurant|
      [restaurant.name, restaurant.id]
    end
    @earliest = Reservation.next_possible_time
  end

  def create
    @reservation = Reservation.new(reservation_params)
    # @reservation.user = current_user
  end

  def create_at_restaurant
    # for reservation links from restaurant page...
  end

private

  def reservation_params
    params.require(:reservation).permit(:restaurant_id, :time, :party_size)
  end
end
