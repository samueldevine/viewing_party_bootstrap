class MoviesController < ApplicationController
  def search
    @query = params[:search]

    conn = Faraday.new(url: "https://api.themoviedb.org/3")
    response = conn.get("search/movie", { query: params[:search], api_key: ENV['movie_api_key'] })

    data = JSON.parse(response.body, symbolize_names: true)
    @movies = data[:results][0..19]

    render :movies
  end

  def movies
  end
end
