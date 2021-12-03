require 'rails_helper'

RSpec.describe 'New Viewing Party' do
  let!(:linda) { User.create!(name: 'Linda Belcher', email: 'lbelcher@yahoo.com') }
  let!(:bob) { User.create!(name: 'Bob Belcher', email: 'bburger@yahoo.com') }

  describe 'happy path' do
    it 'shows a movie title' do
      response = Faraday.get("https://api.themoviedb.org/3/movie/550?api_key=53eaa818ee059d1f9370d4b96b85d585")
      movie = JSON.parse(response.body, symbolize_names: true)

      visit "/users/#{linda.id}/movies/#{movie[:id]}/viewing-party/new"

      expect(page).to have_content("Create a Movie Party for #{movie[:title]}")
    end

    it 'has a form to create viewing party' do
      response = Faraday.get("https://api.themoviedb.org/3/movie/550?api_key=53eaa818ee059d1f9370d4b96b85d585")
      movie = JSON.parse(response.body, symbolize_names: true)

      visit "/users/#{linda.id}/movies/#{movie[:id]}/viewing-party/new"

      fill_in "duration", with: movie[:runtime]
      fill_in "date", with: "12/06/2022"
      fill_in "start_time", with: "12:00"
      check "Add #{linda.name}"
      check "Add #{bob.name}"
      click_button "Create Party"
    end
  end
end

# When I visit the new viewing party page (/users/:user_id/movies/:movid_id/viewing-party/new, where :user_id is a valid user's id),
# I should see the name of the movie title rendered above a form with the following fields:
#
#  Duration of Party with a default value of movie runtime in minutes; a viewing party should NOT be created if set to a value less than the duration of the movie
#  When: field to select date
#  Start Time: field to select time
#  Checkboxes next to each existing user in the system
#  Button to create a party
# Details When the party is created, the user should be redirected back to the dashboard where the new event is shown. The event should also be listed on any other user's dashbaords that were also invited to the party.
