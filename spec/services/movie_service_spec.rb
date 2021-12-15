require 'rails_helper'

RSpec.describe MovieService do
  describe 'helper methods' do
    describe '::conn' do
      it 'creates a faraday connection to TheMovieDB' do
        conn = MovieService.conn

        expect(conn).to be_a Faraday::Connection
      end
    end

    describe '::get_url', :vcr do
      it 'fetches API data for a specific endpoint, and parses it' do
        url = 'movie/top_rated'
        params = { api_key: ENV['movie_api_key']}
        response = MovieService.get_url(url, params)

        expect(response).to be_a Hash
      end
    end
  end

  describe 'endpoint methods' do
    describe '::top_rated', :vcr do
      it 'returns a hash of the top rated movies' do
        top_rated = MovieService.top_rated

        expect(top_rated).to be_a Hash
        expect(top_rated).to have_key :results
        expect(top_rated[:results].first).to have_key :title
      end
    end

    describe '::search', :vcr do
      it 'returns a list of movies that match the search query' do
        search_results = MovieService.search('fight club')

        expect(search_results).to be_a Hash
        expect(search_results).to have_key :results
        expect(search_results[:results].first).to have_key :title
      end
    end

    describe '::movie_details', :vcr do
      it 'returns data for a single movie' do
        movie_data = MovieService.movie_details(550)

        expect(movie_data).to be_a Hash
        expect(movie_data).to have_key :title
      end
    end

    describe '::cast_list', :vcr do
      it 'returns data about a single movies cast' do
        cast_list = MovieService.cast_list(550)

        expect(cast_list).to be_a Hash
        expect(cast_list).to have_key :cast
        expect(cast_list[:cast].first).to have_key :name
      end
    end

    describe '::reviews', :vcr do
      it 'returns data about a single movies reviews' do
        reviews = MovieService.reviews(550)

        expect(reviews).to be_a Hash
        expect(reviews).to have_key :results
        expect(reviews[:results].first).to have_key :author
      end
    end
  end
end
