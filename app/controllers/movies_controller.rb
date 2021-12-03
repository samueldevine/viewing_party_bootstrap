class MoviesController < ApplicationController
  def search
    @user = User.find(params[:id])
    if params[:search] == 'top_rated'
      @movies = MovieFacade.top_rated.all
      render :movies
    elsif params[:q] != ''
      @query = params[:q]
      @movies = MovieFacade.search(@query).all
      render :movies
    else
      render 'users/discover'
    end
  end

  def movies
  end

  def detail
    # @movie_details #==> [@movie, @cast_list, @reviews]

    @movie = MovieFacade.movie_details(params[:movie_id])

    @cast_list = MovieFacade.cast_list(params[:movie_id])

    @reviews = MovieFacade.reviews(params[:movie_id])
  end

end
