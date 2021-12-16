require 'rails_helper'

RSpec.describe "A User's Dashboard" do
  before :each do
    @bob = User.create(name: 'Bob Belcher', email: 'bburger@yahoo.com', password: 'burger', password_confirmation: 'burger')
    visit '/login'
    fill_in :email, with: 'bburger@yahoo.com'
    fill_in :password, with: 'burger'
    click_on 'Log In'
  end

  describe 'User Info section' do
    it 'displays the name of the user' do
      visit "/dashboard"

      expect(page).to have_content "Bob Belcher's Dashboard"
    end
  end

  describe 'discover section' do
    it 'has a button to discover movies' do
      visit "/dashboard"

      expect(page).to have_button 'Discover Movies'

      click_on 'Discover Movies'

      expect(current_path).to eq "/discover"
    end
  end

  describe 'viewing parties section' do
    it 'has a section that lists viewing parties' do
      visit "/dashboard"

      within '#viewing-parties' do
        expect(page).to have_content 'Viewing Parties'
        expect(page).to have_content 'No viewing parties yet.'
      end
    end

    it 'displays an image and information for each of the users parties', :vcr do
      party_1 = @bob.viewing_parties.create!(movie_id: 550, host_id: @bob.id, start_time: '18:00', date: '2022-Jan-01')
      visit "/dashboard"

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
      linda = User.create!(name: 'Linda Belcher', email: 'dancingmom@yahoo.com', password: 'dancemom', password_confirmation: 'dancemom')
      party_1 = @bob.viewing_parties.create!(movie_id: 550, host_id: @bob.id, start_time: '18:00', date: '2022-Jan-01')
      party_2 = linda.viewing_parties.create!(movie_id: 551, host_id: linda.id, start_time: '18:00', date: '2022-Jan-01')
      party_2.users << @bob
      visit "/dashboard" # current user is @bob

      within '#viewing-parties' do
        within "#party-#{party_1.id}" do
          expect(page).to have_content 'Hosting'
        end
        within "#party-#{party_2.id}" do
          expect(page).to have_content 'Invited'
        end
      end
    end

    it "doesn't dispaly information about other users' parties that I haven't been invited to" do
      linda = User.create!(name: 'Linda Belcher', email: 'dancingmom@yahoo.com', password: 'dancemom', password_confirmation: 'dancemom')
      party_1 = linda.viewing_parties.create!(movie_id: 550, host_id: @bob.id, start_time: '18:00', date: '2022-Jan-01')

      visit "/dashboard"

      within '#viewing-parties' do
        expect(page).to have_content 'No viewing parties yet.'
      end
    end
  end
end
