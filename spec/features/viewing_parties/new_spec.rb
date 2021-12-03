require 'rails_helper'

RSpec.describe 'New Viewing Party' do
  before :each do
    @linda = User.create!(name: 'Linda Belcher', email: 'lbelcher@yahoo.com')
    @bob = User.create!(name: 'Bob Belcher', email: 'bburger@yahoo.com')
    @gene = User.create!(name: 'Gene Belcher', email: 'gbelcher@yahoo.com')
  end

  describe 'happy path' do
    it 'shows a movie title', :vcr do
      movie = MovieFacade.movie_details(550)
      visit "/users/#{@linda.id}/movies/#{movie.id}/viewing-party/new"

      expect(page).to have_content("Create a Movie Party for #{movie.title}")
    end

    it 'has a form to create viewing party', :vcr do
      movie = MovieFacade.movie_details(550)
      visit "/users/#{@linda.id}/movies/#{movie.id}/viewing-party/new"

      fill_in "duration", with: movie.runtime
      fill_in "date", with: "06/12/2022"
      fill_in "start_time", with: "12:00"
      check "[invitations][#{@linda.id}]"
      check "[invitations][#{@bob.id}]"
      click_button "Create Party"

      expect(current_path).to eq("/users/#{@linda.id}")
      expect(page.status_code).to eq 200
      expect(page).to have_content(movie.title)
      expect(page).to have_content("December 06, 2022")
      expect(page).to have_content("12:00 PM")
      expect(page).to have_content("Hosting")

      visit "/users/#{@bob.id}"

      expect(page.status_code).to eq 200
      expect(page).to have_content(movie.title)
      expect(page).to have_content("December 06, 2022")
      expect(page).to have_content("12:00 PM")
      expect(page).to have_content("Invited")

      visit "/users/#{@gene.id}"
      expect(page.status_code).to eq 200
      expect(page).to_not have_content(movie.title)
    end
  end

  describe 'sad path' do
    it 'prevents a party from being created with a shorter duration than the movie', :vcr do
      movie = MovieFacade.movie_details(550)
      visit "/users/#{@linda.id}/movies/#{movie.id}/viewing-party/new"

      fill_in "duration", with: (movie.runtime - 5)
      fill_in "date", with: "06/12/2022"
      fill_in "start_time", with: "12:00"
      check "[invitations][#{@linda.id}]"
      check "[invitations][#{@bob.id}]"
      click_button "Create Party"

      expect(current_path).to eq "/users/#{@linda.id}/movies/#{movie.id}/viewing-party"
      expect(page).to have_content "Please choose a duration longer than the movie's runtime."
    end
  end
end
