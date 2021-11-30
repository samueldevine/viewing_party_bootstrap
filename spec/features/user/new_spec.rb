require 'rails_helper'

RSpec.describe "User Registration Page" do
  before :each do
    @user1 = User.create!(name: "Bob Belcher", email: "bburger@yahoo.com")
  end

  it 'shows a registration form' do
    visit "/register"
    
    fill_in :name, with: "Bob Belcher"
    fill_in :email, with: "bburger@yahoo.com"
    click_button "Register"

    user = User.all.last

    expect(current_path).to eq("/users/#{user.id}")
    expect(page).to have_content("Name: Bob Belcher")
    expect(page).to have_content("Email: bburger@yahoo.com")
  end
end
