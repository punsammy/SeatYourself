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
