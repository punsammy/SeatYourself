class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to reservations_url, notice: "Signed Up!"
    else
      render "new"
    end
  end

  def edit
    @user = User.find (params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password_digest, :postal_code)
  end
end
