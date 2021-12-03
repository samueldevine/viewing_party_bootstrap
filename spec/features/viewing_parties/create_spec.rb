require 'rails_helper'

RSpec.describe 'Create Viewing Party' do
  before :each do
    @linda = User.create!(name: 'Linda Belcher', email: 'lbelcher@yahoo.com')
    @bob = User.create!(name: 'Bob Belcher', email: 'bburger@yahoo.com')
    @gene = User.create!(name: 'Gene Belcher', email: 'gbelcher@yahoo.com')
  end

  describe 'happy path' do
    it 'can add viewing party to'
  end
end
