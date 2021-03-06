class ReservationsController < ApplicationController

  def index
    @user = current_user
    if @user
      render :index# Only the user who made the reservation can view it.
    else
      # redirect_to either restaurants or users homepage.
      flash.now[:alert] = "Please Log in!"
      redirect_to restaurants_path
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
    if current_user == @reservation.user
      # These should eventually be instance methods
      set_form_vars
    else
      flash[:alert] = "Pleas log in or sign up first."
      redirect_to restaurants_path
    end
  end

  def update
    @reservation = Reservation.find(params[:id])
    if current_user == @reservation.user
      if @reservation.update_attributes(reservation_params)
        redirect_to reservation_path(@reservation)
      else
        set_form_vars
        render :edit
      end
    else
      flash[:alert] = "Pleas log in or sign up first."
      redirect_to restaurants_path
    end
  end

  def restaurant_index
    @restaurant = Restaurant.find(params[:id])
    if @restaurant
      unless @restaurant.user_id == current_user
        # Only the owner can view the current reservations.
        redirect_to restaurant_path(@restaurant)
      end
    else

    end
  end

  def show
    @reservation = Reservation.find(params[:id])
    @restaurant = @reservation.restaurant
    if @reservation.user == current_user
      # Only the user who made the reservation can view it.
      render :show
    else
      # redirect_to either restaurants or users homepage.
      flash.now[:alert] = "#{@reservation.user}"
      redirect_to restaurants_path
    end
  end

  def new
    if current_user
      @reservation = Reservation.new
      @reservation.user = current_user
      # These should eventually be instance methods
      set_form_vars
    else
      flash[:alert] = "Please log in or sign up first."
      redirect_to restaurants_path
    end
  end

  def create
    if current_user
      @reservation = Reservation.new(reservation_params)
      @reservation.user = current_user
      if @reservation.save
        flash[:notice] = "Thank you for making a reservation!"
        redirect_to reservation_path(@reservation)
      else
        # flash.now[:alert] = "Sorry, we cannot make that reservation."
        set_form_vars
        render :new
      end
    else
      flash.now[:alert] = 'Please log in first.'
      redirect_to restaurants_path
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
      redirect_to restaurants_path
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
    @min_hour = Restaurant.default_opening_time.getlocal.hour
    @max_hour = Restaurant.default_closing_time.getlocal.hour - 1
    # min_notice = 30 * 60 # 30 minutes
    @earliest = Reservation.next_possible_time

    @restaurant_list = Restaurant.all.map do |restaurant|
      [restaurant.name, restaurant.id]
    end
  end

end
