require 'rails_helper'

RSpec.describe 'Movie Detail Page' do
  let(:linda) { User.create!(name: 'Linda Belcher', email: 'lbelcher@yahoo.com') }

  it 'shows a movie and its attributes' do
    response = Faraday.get("https://api.themoviedb.org/3/movie/550?api_key=53eaa818ee059d1f9370d4b96b85d585")
    movie = JSON.parse(response.body, symbolize_names: true)
    #start on linda search page
    visit "/users/#{linda.id}/movies/#{movie[:id]}"

    expect(page).to have_content("Fight Club")
    expect(page).to have_content(8.4)
    expect(page).to have_content("Runtime in hours: 2.32")
    expect(page).to have_content("Drama")
    expect(page).to have_content("A ticking-time-bomb")
    expect(page).to have_content(22933)
    expect(page).to have_content("Edward Norton as The Narrator")
    expect(page).to_not have_content("David Jean Thomas as Policeman")
    expect(page).to have_content("Brett Pascoe: In my top 5 of all time favourite movies")
  end

  it 'can create a viewing party' do
    response = Faraday.get("https://api.themoviedb.org/3/movie/550?api_key=53eaa818ee059d1f9370d4b96b85d585")
    movie = JSON.parse(response.body, symbolize_names: true)
    visit "/users/#{linda.id}/movies/#{movie[:id]}"
    save_and_open_page
    click_button "Create Viewing Party"

    expect(current_path). to eq("/users/#{linda.id}/movies/#{movie[:id]}/viewing-party/new")
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
