class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create!(user_params)

    redirect_to "/users/#{@user.id}"
  end

  def show
    user = User.find(params[:user_id])
  end

  private
    def user_params
      params.permit(:name, :email)
    end
end
