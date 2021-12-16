class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Successfully logged in'
      redirect_to "/users/#{user.id}"
    else
      flash[:warning] = 'Invalid username or password'
      redirect_to '/login'
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end
end
