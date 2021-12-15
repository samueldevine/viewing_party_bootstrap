require 'rails_helper'

RSpec.describe 'The Landing Page' do
  it 'has a button to create a new user' do
    visit root_path

    expect(page).to have_button 'Create a New User'
    click_on 'Create a New User'

    expect(current_path).to eq "/register"
  end

  it 'lists all current users' do
    bob = User.create(name: 'Bob Belcher', email: 'bburger@yahoo.com', password: 'burger', password_confirmation: 'burger')
    visit root_path

    within '#existing-users' do
      expect(page).to have_content(bob.email)
    end
  end

  it 'links to each users dashboard' do
    bob = User.create(name: 'Bob Belcher', email: 'bburger@yahoo.com', password: 'burger', password_confirmation: 'burger')
    visit root_path

    within '#existing-users' do
      click_on 'bburger@yahoo.com'
    end

    expect(current_path).to eq "/users/#{bob.id}"
  end
end
