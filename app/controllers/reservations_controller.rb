class ReservationsController < ApplicationController

  def show
    @reservation = Reservation.find(params[:id])
    @restaurant = @reservation.restaurant
    if @reservation.user == current_user
      # Only the user who made the reservation can view it.
      render :show
    else
      # redirect_to either restaurants or users homepage.
      redirect_to restaurants_path
    end
  end

  def new
    @reservation = Reservation.new
    # These should eventually be instance methods
    set_form_vars
  end

  def create
    @reservation = Reservation.new(reservation_params)
    # @reservation.user = current_user
    if @reservation.save
      flash[:notice] = "Thank you for making a reservation!"
      redirect_to reservation_path(@reservation)
    else
      flash.now[:alert] = "Sorry, we cannot make that reservation."
      set_form_vars
      render :new
    end
  end

  def create_at_restaurant
    # for reservation links from restaurant page...
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @restaurant = @reservation.restaurant
    if @reservation.user == current_user
      @reservation.destroy
      flash[:notice] = "Your reservation has been cancelled."
    else
      # redirect_to either restaurants or users homepage.
      redirect_to restaurants_path
    end
  end

private

  def reservation_params
    params.require(:reservation).permit(:restaurant_id, :time, :party_size)
  end

  def set_form_vars
    @min_hour = Restaurant.opening.hour
    @max_hour = Restaurant.closing.hour - 1
    # min_notice = 30 * 60 # 30 minutes
    @earliest = Reservation.next_possible_time

    @restaurant_list = Restaurant.all.map do |restaurant|
      [restaurant.name, restaurant.id]
    end
  end

end
