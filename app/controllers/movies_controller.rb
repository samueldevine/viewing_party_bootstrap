class MoviesController < ApplicationController
  def search
    if params[:search] != ''
      @query = params[:search]

      conn = Faraday.new(url: "https://api.themoviedb.org/3")
      response = conn.get("search/movie", { query: params[:search], api_key: ENV['movie_api_key'] })

      data = JSON.parse(response.body, symbolize_names: true)
      @movies = data[:results][0..19]

      render :movies
    else
      @user = User.find(params[:id])
      render 'users/discover'
    end
  end

  def top_rated
    conn = Faraday.new(url: "https://api.themoviedb.org/3")
    response = conn.get("movie/top_rated", { api_key: ENV['movie_api_key']})

    data = JSON.parse(response.body, symbolize_names: true)
    @movies = data[:results][0..19]

    render :movies
  end

  def movies
  end

  def detail
    conn = Faraday.new(url: "https://api.themoviedb.org/3")
    response = conn.get("movie/550?", { api_key: ENV['movie_api_key']})
    @movie = JSON.parse(response.body, symbolize_names: true)

    response2 = conn.get("movie/550/credits", { api_key: ENV['movie_api_key']})
    data = JSON.parse(response2.body, symbolize_names: true)
    @cast_list = data[:cast][0..9]

    response3 = conn.get("movie/550/reviews", { api_key: ENV['movie_api_key']})
    data = JSON.parse(response3.body, symbolize_names: true)
    @reviews = data[:results]
  end

end
