require 'rails_helper'

RSpec.describe "A User's Dashboard" do
  let(:sam) { User.create(name: 'Sam', email: 'sam@sam.com') }

  it 'displays the name of the user' do
    visit user_path(sam)

    expect(page).to have_content "Sam's Dashboard"
  end

  it 'has a button to discover movies' do
    visit user_path(sam)

    expect(page).to have_button 'Discover Movies'

    click_on 'Discover Movies'

    expect(current_path).to eq "/users/#{sam.id}/discover"
  end

  it 'has a section that lists viewing parties' do
    visit user_path(sam)

    within '#viewing-parties' do
      expect(page).to have_content 'Viewing Parties'
    end
  end
end
