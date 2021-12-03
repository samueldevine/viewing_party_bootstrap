class UsersController < ApplicationController
  def dashboard
    @user = User.find(params[:id])
    viewing_parties = ViewingParty.find_by_user(@user)
    if viewing_parties != []
      @party_details = MovieFacade.party_details(viewing_parties)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create!(user_params)

    redirect_to "/users/#{@user.id}"
  end

  def discover
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.permit(:name, :email)
  end
end
