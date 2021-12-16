require 'rails_helper'

RSpec.describe 'The Landing Page' do
  it 'has a button to create a new user' do
    visit root_path

    expect(page).to have_button 'Create an account'
    click_on 'Create an account'

    expect(current_path).to eq '/register'
  end

  it 'has a button to log in' do
    visit root_path

    expect(page).to have_button 'Log In'

    click_on 'Log In'

    expect(current_path).to eq '/login'
  end
end
