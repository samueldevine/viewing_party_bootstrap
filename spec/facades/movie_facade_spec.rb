require 'rails_helper'

RSpec.describe MovieFacade do
  describe 'methods' do
    describe '::top_rated' do
      it 'returns the top 20 movies from TheMovieDB API', :vcr do
        top_rated = MovieFacade.top_rated

        expect(top_rated).to be_a MovieRepo
        expect(top_rated.all.first).to be_a Movie
        expect(top_rated.all.first.title).to be_a String
      end
    end

    describe '::search', :vcr do
      it 'returns up to 20 movies that match the search params' do
        results = MovieFacade.search('harry potter')

        expect(results).to be_a MovieRepo
        expect(results.all.first).to be_a Movie
        expect(results.all.first.title).to be_a String
        expect(results.all.length).to be <= 20
      end

      it 'returns an empty repo if no movies match the users search', :vcr do
        results = MovieFacade.search("linkedin.com/samueldevine")

        expect(results).to be_a MovieRepo
        expect(results.all).to be_empty
      end
    end

    describe '::movie_details' do
      it 'returns a movie object for a single movie', :vcr do
        movie = MovieFacade.movie_details(1000)

        expect(movie).to be_a Movie
      end
    end
  end
end
