require 'rails_helper'

RSpec.describe 'Discover Movies Results' do
  let(:bob) { User.create!(name: 'Bob Belcher', email: 'bburger@yahoo.com', password: 'burger', password_confirmation: 'burger') }

  describe 'movie search' do
    describe 'happy path' do
      it 'allows users to search for a movie by title', :vcr do
        visit "/users/#{bob.id}/discover"

        fill_in :q, with: 'national treasure'
        click_button 'Find Movies'

        expect(page.status_code).to eq 200
        expect(page).to have_content('National Treasure')
        expect(page).to have_content('Vote Average:', count: 11)
      end

      it 'only displays up to 20 movies', :vcr do
        visit "/users/#{bob.id}/discover"

        fill_in :q, with: 'fight'
        click_button 'Find Movies'

        expect(page.status_code).to eq 200
        expect(page).to have_content('Fight Club')
        expect(page).to have_content('Vote Average:', count: 20)
      end
    end

    describe 'sad path' do
      it 'does nothing if no query is entered' do
        visit "/users/#{bob.id}/discover"
        click_button 'Find Movies'

        expect(page.status_code).to eq 200
        expect(current_path).to eq "/users/#{bob.id}/movies"
        expect(page).to have_button 'Find Movies'
      end
    end
  end

  describe 'top rated movies' do
    describe 'happy path' do
      it 'allows users to find the top 20 movies by rating', :vcr do
        visit "/users/#{bob.id}/discover"

        click_button 'Find Top Rated Movies'

        expect(page.status_code).to eq 200
        expect(page).to have_content('The Godfather')
        expect(page).to have_content('Vote Average:', count: 20)
      end
    end
  end

  describe 'Discover Page button' do
    it 'routes users back to the discover page', :vcr do
      visit "/users/#{bob.id}/discover"
      click_button 'Find Top Rated Movies'
      click_button 'Discover Page'

      expect(page.status_code).to eq 200
      expect(current_path).to eq "/users/#{bob.id}/discover"
    end
  end

  describe 'results' do
    # this test may fail if someone ever makes another movie called 'fight club'
    # and capybara finds an ambiguous match (two links with the same name)
    it 'each title links to the movies show page', :vcr do
      movie = MovieFacade.search('fight club').all.first
      visit "/users/#{bob.id}/discover"
      fill_in :q, with: "#{movie.title}"
      click_button 'Find Movies'
      click_link "#{movie.title}"

      expect(current_path).to eq "/users/#{bob.id}/movies/#{movie.id}"
      expect(page.status_code).to eq 200
    end
  end
end
