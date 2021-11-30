class MoviesController < ApplicationController
  def search
    conn = Faraday.new(url: "https://api.themoviedb.org/3") do |faraday|
      # faraday.headers["api_key"] = ENV['movie_api_key']
    end
    # response = conn.get("/search/movie", { 'api_key': ENV['movie_api_key'] })
    response = conn.get("/search/movie", { query: params[:search], api_key: ENV['movie_api_key'] })
    binding.pry
    data = JSON.parse(response.body, symbolize_names: true)

    @movies = data[0..19]

    # found_movies = movies.find_all {|m| m[:title] == params[:search]}
    # movies = found_movies.first
    # render "welcome/index"
  end
end
