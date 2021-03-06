class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect_to reservations_url, notice: "Successfully Logged In!"
     else
       flash.now[:alert] = "Invalid email or password"
       render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Successfully Logged Out!"
  end
end
