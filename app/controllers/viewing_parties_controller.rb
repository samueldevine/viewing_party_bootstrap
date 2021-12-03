class ViewingPartiesController < ApplicationController
  def new
    @user = User.find(params[:id])
    @users = User.all
    facade = MovieFacade.new
    @movie = facade.movie_details(params[:movie_id])

    #redirect to users dashboard
  end

  def create
    viewing_party = ViewingParty.create!(
      movie_id: params[:movie_id],
      host_id: params[:id],
      date: params[:date],
      start_time: params[:start_time],
      duration: params[:duration]
      )

      binding.pry
  end
end
