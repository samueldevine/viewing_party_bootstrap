require 'rails_helper'

RSpec.describe 'Login Page' do
  before :each do
    @bob = User.create(name: 'Bob Belcher', email: 'bburger@yahoo.com', password: 'burger',
                       password_confirmation: 'burger')
  end

  describe 'with valid info (happy path)' do
    it 'checks if a user entered the correct password' do
      visit '/login'

      fill_in :email, with: 'bburger@yahoo.com'
      fill_in :password, with: 'burger'
      click_on 'Log In'

      expect(current_path).to eq '/dashboard'
    end
  end

  describe 'with invalid info (sad path)' do
    it 're-renders the login page if email is wrong' do
      visit '/login'

      fill_in :email, with: 'linda@yahoo.com'
      fill_in :password, with: 'burger'
      click_on 'Log In'

      expect(current_path).to eq '/login'
      expect(page).to have_content 'Invalid username or password'
    end

    it 're-renders the login page if password is wrong' do
      visit '/login'

      fill_in :email, with: 'bburger@yahoo.com'
      fill_in :password, with: 'sandwich'
      click_on 'Log In'

      expect(current_path).to eq '/login'
      expect(page).to have_content 'Invalid username or password'
    end
  end
end
