require 'rails_helper'

RSpec.describe "A User's Dashboard" do
  let(:bob) { User.create(name: 'Bob Belcher', email: 'bburger@yahoo.com') }

  it 'displays the name of the user' do
    visit "/users/#{bob.id}"

    expect(page).to have_content "Bob Belcher's Dashboard"
  end

  it 'has a button to discover movies' do
    visit "/users/#{bob.id}"

    expect(page).to have_button 'Discover Movies'

    click_on 'Discover Movies'

    expect(current_path).to eq "/users/#{bob.id}/discover"
  end

  it 'has a section that lists viewing parties' do
    visit "/users/#{bob.id}"

    within '#viewing-parties' do
      expect(page).to have_content 'Viewing Parties'
    end
  end
end
