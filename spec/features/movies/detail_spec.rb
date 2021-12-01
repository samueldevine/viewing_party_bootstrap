require 'rails_helper'

RSpec.describe 'Movie Detail Page' do
  let(:bob) { User.create(name: 'Bob Belcher', email: 'bburger@yahoo.com') }

  it 'shows a movie and its attributes' do
    response = Faraday.get("https://api.themoviedb.org/3/movie/550?api_key=53eaa818ee059d1f9370d4b96b85d585")
    movie = JSON.parse(response.body, symbolize_names: true)
  
    visit "/users/#{bob.id}/movies/#{movie[:id]}"

    expect(page).to have_content('Fight Club')

  end

  xit 'can create a viewing party' do
  end

  xit 'links back to the discover page' do
  end
end

# When I visit a movie's detail page (/users/:user_id/movies/:movie_id where :id is a valid user id,
# I should see
#
#  Button to create a viewing party
#  Button to return to the Discover Page
# Details This viewing party button should take the user to the new viewing party page (/users/:user_id/movies/:movie_id/viewing-party/new)
#
# And I should see the following information about the movie:
#
#  Movie Title
#  Vote Average of the movie
#  Runtime in hours & minutes
#  Genre(s) associated to movie
#  Summary description
#  List the first 10 cast members (characters&actress/actors)
#  Count of total reviews
#  Each review's author and information
# Details: This information should come from 3 different endpoints from The Movie DB API
