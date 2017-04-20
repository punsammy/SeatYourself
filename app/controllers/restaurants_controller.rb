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

  def create
    @restaurants = Restaurant.new(Restaurant_params)

    if @restaurants.save
      redirect_to Restaurants_url
    else
      render :new
    end
  end

  def update
    @restaurants = Restaurant.find(params[:id])

    if @restaurants.update_attributes(Restaurant_params)
      redirect_to Restaurant_url(@restaurants)
    else
      render :edit
    end
  end

  def destroy
    @restaurants = Restaurant.find(params[:id])
    @restaurants.destroy
    redirect_to Restaurants_url
  end

  private
  def Restaurant_params
    params.require(:Restaurant).permit(:name, :address, :phone_number, :description, :capacity)
  end
end
