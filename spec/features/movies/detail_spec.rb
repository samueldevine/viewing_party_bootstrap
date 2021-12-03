require 'rails_helper'

RSpec.describe 'Movie Detail Page' do
  let(:linda) { User.create!(name: 'Linda Belcher', email: 'lbelcher@yahoo.com') }

  it 'shows a movie and its attributes', :vcr do
    movie = MovieFacade.movie_details(550)
    visit "/users/#{linda.id}/movies/#{movie.id}"

    expect(page).to have_content("Fight Club")
    expect(page).to have_content(movie.vote_average)
    expect(page).to have_content("Runtime in hours: 2.32")
    expect(page).to have_content("Drama")
    expect(page).to have_content("A ticking-time-bomb")
    expect(page).to have_content(movie.vote_count)
    expect(page).to have_content("Edward Norton as The Narrator")
    expect(page).to_not have_content("David Jean Thomas as Policeman")
    expect(page).to have_content("Brett Pascoe: In my top 5 of all time favourite movies")
  end

  it 'can create a viewing party', :vcr do
    movie = MovieFacade.movie_details(550)
    visit "/users/#{linda.id}/movies/#{movie.id}"
    click_button "Create Viewing Party"

    expect(current_path).to eq("/users/#{linda.id}/movies/#{movie.id}/viewing-party/new")
  end

  it 'links back to the discover page', :vcr do
    movie = MovieFacade.movie_details(550)
    visit "/users/#{linda.id}/movies/#{movie.id}"
    click_button "Back to Discover Movies"

    expect(current_path).to eq("/users/#{linda.id}/discover")
  end
end
