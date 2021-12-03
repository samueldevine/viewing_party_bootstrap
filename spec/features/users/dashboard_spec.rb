require 'rails_helper'

RSpec.describe "A User's Dashboard" do
  let(:bob) { User.create(name: 'Bob Belcher', email: 'bburger@yahoo.com') }

  describe 'User Info section' do
    it 'displays the name of the user' do
      visit "/users/#{bob.id}"

      expect(page).to have_content "Bob Belcher's Dashboard"
    end
  end

  describe 'discover section' do
    it 'has a button to discover movies' do
      visit "/users/#{bob.id}"

      expect(page).to have_button 'Discover Movies'

      click_on 'Discover Movies'

      expect(current_path).to eq "/users/#{bob.id}/discover"
    end
  end

  describe 'viewing parties section' do
    it 'has a section that lists viewing parties' do
      visit "/users/#{bob.id}"

      within '#viewing-parties' do
        expect(page).to have_content 'Viewing Parties'
        expect(page).to have_content 'No viewing parties yet.'
      end
    end

    it 'displays an image and information for each of the users parties', :vcr do
      party_1 = bob.viewing_parties.create!(movie_id: 550, host_id: bob.id, start_time: '18:00', date: '2022-Jan-01')
      visit "/users/#{bob.id}"

      within '#viewing-parties' do
        within "#party-#{party_1.id}" do
          expect(page).to have_content 'Fight Club'
          expect(page).to have_content 'January 01, 2022'
          expect(page).to have_content '6:00 PM'
          expect(page).to have_content 'Hosting'
        end
      end
    end

    it 'tells users if they are hosting or invited', :vcr do
      linda = User.create!(name: 'Linda Belcher', email: 'dancingmom@yahoo.com')
      party_1 = bob.viewing_parties.create!(movie_id: 550, host_id: bob.id, start_time: '18:00', date: '2022-Jan-01')
      party_1.users << linda
      party_2 = linda.viewing_parties.create!(movie_id: 551, host_id: linda.id, start_time: '18:00', date: '2022-Jan-01')
      visit "/users/#{linda.id}"

      within '#viewing-parties' do
        within "#party-#{party_1.id}" do
          expect(page).to have_content 'Invited'
        end
        within "#party-#{party_2.id}" do
          expect(page).to have_content 'Hosting'
        end
      end
    end

    it "doesn't dispaly information about other users' parties that I haven't been invited to" do
      linda = User.create!(name: 'Linda Belcher', email: 'dancingmom@yahoo.com')
      party_1 = bob.viewing_parties.create!(movie_id: 550, host_id: bob.id, start_time: '18:00', date: '2022-Jan-01')

      visit "/users/#{linda.id}"

      within '#viewing-parties' do
        expect(page).to have_content 'No viewing parties yet.'
      end
    end
  end
end
