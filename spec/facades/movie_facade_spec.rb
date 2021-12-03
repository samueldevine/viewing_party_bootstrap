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

    describe '::cast_list' do
      it 'returns an array of up to 10 cast members', :vcr do
        cast_list = MovieFacade.cast_list(550)

        expect(cast_list).to be_an Array
        expect(cast_list.size).to eq 10
        expect(cast_list.first).to be_a CastMember
      end
    end

    describe '::reviews' do
      it 'returns an array of reviews', :vcr do
        reviews = MovieFacade.reviews(550)

        expect(reviews).to be_an Array
        expect(reviews.first).to be_a Review
      end
    end

    describe '::party_details' do
      it 'returns an array of arrays, each containing a viewing party and the movie details for that partys movie', :vcr do
        bob = User.create!(name: 'Bob Belcher', email: 'bburger@yahoo.com')
        linda = User.create!(name: 'Linda Belcher', email: 'lbecher@yahoo.com')
        party_1 = bob.viewing_parties.create!(movie_id: 550, host_id: bob.id, start_time: '18:00', date: '2022-Jan-01')
        party_2 = bob.viewing_parties.create!(movie_id: 551, host_id: bob.id, start_time: '12:00', date: '2021-Dec-16')
        party_3 = linda.viewing_parties.create!(movie_id: 552, host_id: linda.id, start_time: '13:00', date: '2021-Dec-17')
        party_4 = linda.viewing_parties.create!(movie_id: 553, host_id: linda.id, start_time: '14:00', date: '2021-Dec-18')
        party_3.users << bob

        party_details = MovieFacade.party_details([party_1, party_2, party_3])

        expect(party_details).to be_an Array
        expect(party_details.first).to be_an Array
        expect(party_details.first[0]).to be_a ViewingParty
        expect(party_details.first[1]).to be_a Movie
      end
    end
  end
end
