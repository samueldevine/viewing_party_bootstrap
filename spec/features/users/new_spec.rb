require 'rails_helper'

RSpec.describe "User Registration Page" do
  describe 'with valid information (happy path)' do
    it 'allows a user to register' do
      visit "/register"

      fill_in :name, with: "Bob Belcher"
      fill_in :email, with: "bburger@yahoo.com"
      fill_in :password, with: "burger"
      fill_in :password_confirmation, with: "burger"
      click_button "Register"

      user = User.all.last

      expect(current_path).to eq("/dashboard")
    end
  end

  describe 'with incorrect or missing information (sad path)' do
    it 'missing name' do
      visit '/register'

      fill_in :email, with: "bburger@yahoo.com"
      fill_in :password, with: "burger"
      fill_in :password_confirmation, with: "burger"
      click_button "Register"

      expect(page).to have_content "Name can't be blank"
      expect(page).to have_button 'Register'
    end

    it 'mismatched passwords' do
      visit '/register'

      fill_in :name, with: 'Bob Belcher'
      fill_in :email, with: "bburger@yahoo.com"
      fill_in :password, with: "burger1"
      fill_in :password_confirmation, with: "burger2"
      click_button "Register"

      expect(page).to have_content "Password confirmation doesn't match Password"
      expect(page).to have_button 'Register'
    end
  end
end
