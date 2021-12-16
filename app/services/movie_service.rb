class MovieService
  class << self
    def get_url(url, params)
      parse_data(conn.get(url, params))
    end

    def top_rated
      get_url('movie/top_rated', { api_key: ENV['movie_api_key'] })
    end

    def search(query)
      get_url('search/movie', { query: query, api_key: ENV['movie_api_key'] })
    end

    def movie_details(movie_id)
      get_url("movie/#{movie_id}?", { api_key: ENV['movie_api_key'] })
    end

    def cast_list(movie_id)
      get_url("movie/#{movie_id}/credits", { api_key: ENV['movie_api_key'] })
    end

    def reviews(movie_id)
      get_url("movie/#{movie_id}/reviews", { api_key: ENV['movie_api_key'] })
    end

    def conn
      Faraday.new(url: 'https://api.themoviedb.org/3')
    end

    def parse_data(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
