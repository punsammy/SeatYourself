class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurants = Restaurant.new
  end

  def edit
    @restaurants = Restaurant.find(params[:id])
  end

  def show
    @restaurants = Restaurant.find(params[:id])
  end

  def create
    @restaurants = Restaurant.new(restaurant_params)

    if @restaurants.save
      redirect_to restaurants_url
    else
      render :new
    end
  end

  def update
    @restaurants = Restaurant.find(params[:id])

    if @restaurants.update_attributes(Restaurant_params)
      redirect_to restaurant_url(@restaurants)
    else
      render :edit
    end
  end

  def destroy
    @restaurants = Restaurant.find(params[:id])
    @restaurants.destroy
    redirect_to restaurants_url
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :phone_number, :description, :capacity)
  end
end
