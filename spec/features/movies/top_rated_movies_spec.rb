require 'rails_helper'

RSpec.describe 'Top Rated Movies' do
  describe 'happy path' do
    let(:bob) { User.create(name: 'Bob Belcher', email: 'bburger@yahoo.com') }

    it 'allows users to find the top 20 movies by rating' do
      visit "/users/#{bob.id}/discover"

      click_button 'Find Top Rated Movies'

      expect(page.status_code).to eq 200
      expect(page).to have_content('The Godfather')
      expect(page).to have_content('Vote Average:', count: 20)
    end
  end
end
