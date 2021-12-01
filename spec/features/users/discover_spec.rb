require 'rails_helper'

RSpec.describe 'The Discover Page' do
  let(:sam) { User.create(name: 'Sam', email: 'sam@sam.com') }

  it 'displays the users name' do
    visit "/users/#{sam.id}/discover"

    expect(page).to have_content "Discover Movies"
  end

  it 'has a button to find top rated movies' do
    visit "/users/#{sam.id}/discover"

    click_on "Find Top Rated Movies"

    expect(current_path).to eq "/users/#{sam.id}/movies"
  end

  it 'has a search bar to search for specific movies' do
    visit "/users/#{sam.id}/discover"

    fill_in :search, with: "fight"
    click_on "Find Movies"

    expect(current_path).to eq "/users/#{sam.id}/movies"
    expect(page).to have_content "fight"
  end
end
