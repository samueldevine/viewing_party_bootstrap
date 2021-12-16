require 'rails_helper'

RSpec.describe 'New Viewing Party' do
  before :each do
    @linda = User.create!(name: 'Linda Belcher', email: 'lbelcher@yahoo.com', password: 'dancemom',
                          password_confirmation: 'dancemom')
    @bob = User.create!(name: 'Bob Belcher', email: 'bburger@yahoo.com', password: 'burger',
                        password_confirmation: 'burger')
    @gene = User.create!(name: 'Gene Belcher', email: 'gbelcher@yahoo.com', password: 'burger2',
                         password_confirmation: 'burger2')
    visit '/login'
    fill_in :email, with: 'lbelcher@yahoo.com'
    fill_in :password, with: 'dancemom'
    click_on 'Log In'
  end

  describe 'happy path' do
    it 'shows a movie title', :vcr do
      movie = MovieFacade.movie_details(550)
      visit "/movies/#{movie.id}/viewing-party/new"

      expect(page).to have_content("Create a Viewing Party for #{movie.title}")
    end

    it 'has a form to create viewing party', :vcr do
      movie = MovieFacade.movie_details(550)
      visit "/movies/#{movie.id}/viewing-party/new"

      fill_in 'duration', with: movie.runtime
      fill_in 'date', with: '06/12/2022'
      fill_in 'start_time', with: '12:00'
      check "[invitations][#{@bob.id}]"
      click_button 'Create Party'

      expect(current_path).to eq('/dashboard')
      expect(page.status_code).to eq 200
      expect(page).to have_content(movie.title)
      expect(page).to have_content('December 06, 2022')
      expect(page).to have_content('12:00 PM')
      expect(page).to have_content('Hosting')

      click_on 'Log Out'
      visit '/login'
      fill_in :email, with: 'bburger@yahoo.com'
      fill_in :password, with: 'burger'
      click_on 'Log In'

      expect(page.status_code).to eq 200
      expect(page).to have_content(movie.title)
      expect(page).to have_content('December 06, 2022')
      expect(page).to have_content('12:00 PM')
      expect(page).to have_content('Invited')

      click_on 'Log Out'
      visit '/login'
      fill_in :email, with: 'gbelcher@yahoo.com'
      fill_in :password, with: 'burger2'
      click_on 'Log In'

      expect(page.status_code).to eq 200
      expect(page).to_not have_content(movie.title)
    end
  end

  describe 'sad path' do
    it 'prevents a party from being created with a shorter duration than the movie', :vcr do
      movie = MovieFacade.movie_details(550)
      visit "/movies/#{movie.id}/viewing-party/new"

      fill_in 'duration', with: (movie.runtime - 5)
      fill_in 'date', with: '06/12/2022'
      fill_in 'start_time', with: '12:00'
      check "[invitations][#{@bob.id}]"
      click_button 'Create Party'

      expect(current_path).to eq "/movies/#{movie.id}/viewing-party"
      expect(page).to have_content "Please choose a duration longer than the movie's runtime."
    end
  end
end
