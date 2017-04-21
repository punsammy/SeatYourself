class HomeController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def show
   @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    # make a new picture with what picture_params returns (which is a method we're calling)
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      # if the save for the picture was successful, go to index.html.erb
      redirect_to restaurants_url
    else
      # otherwise render the view associated with the action :new (i.e. new.html.erb)
      flash.now[:alert] = @restaurant.errors.full_messages
      render :new
    end
  end

  def edit
      @restaurant = Restaurant.find(params[:id])
    end

  def destroy
     @restaurant = Restaurant.find(params[:id])
     @restaurant.destroy
     redirect_to restaurants_url
   end

  def update
    @restaurant = Restaurant.find(params[:id])

      if @restaurant.update_attributes(restaurant_params)
        redirect_to "/restaurants/#{@restaurant.id}"
      else
        render :edit
      end
    end

    private
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :phone_number, :description, :capacity)
    end
end
