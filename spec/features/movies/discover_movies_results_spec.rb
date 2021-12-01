require 'rails_helper'

RSpec.describe 'Discover Movies Results' do
  let(:bob) { User.create!(name: 'Bob Belcher', email: 'bburger@yahoo.com') }

  describe 'movie search' do
    describe 'happy path' do
      it 'allows users to search for a movie by title' do
        visit "/users/#{bob.id}/discover"

        fill_in :q, with: 'national treasure'
        click_button 'Find Movies'

        expect(page.status_code).to eq 200
        expect(page).to have_content('National Treasure')
        expect(page).to have_content('Vote Average:', count: 11)
      end

      it 'only displays up to 20 movies' do
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
      it 'allows users to find the top 20 movies by rating' do
        visit "/users/#{bob.id}/discover"

        click_button 'Find Top Rated Movies'

        expect(page.status_code).to eq 200
        expect(page).to have_content('The Godfather')
        expect(page).to have_content('Vote Average:', count: 20)
      end
    end
  end
end
