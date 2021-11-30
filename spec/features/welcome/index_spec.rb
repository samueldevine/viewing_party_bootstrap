require 'rails_helper'

RSpec.describe 'The Landing Page' do
  it 'has a button to create a new user' do
    visit '/'

    expect(page).to have_button 'Create a New User'
    click_on 'Create a New User'

    expect(current_path).to eq "/users/new"
  end

  it 'lists all current users' do
    sam = User.create!(name: 'Sam D.', email: 'sam@sam.com')
    visit '/'

    within '#existing-users' do
      expect(page).to have_content(sam.email)
    end
  end

  it 'links to each users dashboard' do
    sam = User.create(name: 'Sam D.', email: 'sam@sam.com')
    visit '/'

    within '#existing-users' do
      click_on "sam@sam.com's Dashboard"
    end

    expect(current_path).to eq "/users/#{sam.id}"
  end
end
