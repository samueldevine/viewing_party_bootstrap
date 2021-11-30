require 'rails_helper'

RSpec.describe "User Registration Page" do
  it 'shows a registration form' do
    visit "/register"

    fill_in :name, with: "Bob Belcher"
    fill_in :email, with: "bburger@yahoo.com"
    click_button "Register"

    user = User.all.last

    expect(current_path).to eq("/users/#{user.id}")
  end
end
