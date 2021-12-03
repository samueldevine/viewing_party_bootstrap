class ViewingPartiesController < ApplicationController
  def new
    @user = User.find(params[:id])
    @users = User.all
    @movie = MovieFacade.movie_details(params[:movie_id])
  end

  def create
    viewing_party = ViewingParty.create!(
      movie_id: params[:movie_id],
      host_id: params[:id],
      date: params[:date],
      start_time: params[:start_time],
      duration: params[:duration]
      )

    params[:invitations].each do |inv|
      if inv[1] == "1"
        viewing_party.users << User.find(inv[0])
      end
    end

    redirect_to "/users/#{params[:id]}"
  end
end
