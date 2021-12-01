class MoviesController < ApplicationController
  def search
    conn = Faraday.new(url: "https://api.themoviedb.org/3")

    if params[:search] == 'top_rated'
      response = conn.get("movie/top_rated", { api_key: ENV['movie_api_key']})
      data = JSON.parse(response.body, symbolize_names: true)
      @movies = data[:results][0..19]
      render :movies
    elsif params[:search] != ''
      @query = params[:search]
      response = conn.get("search/movie", { query: params[:search], api_key: ENV['movie_api_key'] })
      data = JSON.parse(response.body, symbolize_names: true)
      @movies = data[:results][0..19]
      render :movies
    else
      @user = User.find(params[:id])
      render 'users/discover'
    end
  end

  def movies
  end
end
