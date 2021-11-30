require 'rails_helper'

RSpec.describe "User Show Page" do
  before :each do
    @user1 = User.create!(name: "Bob Belcher", email: "bburger@yahoo.com")
  end
  it "shows a user and it's attributes" do
    visit "/users/#{@user1.id}"
  end
end

# When a user visits the '/register' path they should see a form to register.
#
# The form should include:
#
#  Name
#  Email (must be unique)
#  Register Button
# Once the user registers they should be taken to a dashboard page '/users/:id', where :id is the id for the user that was just created.
