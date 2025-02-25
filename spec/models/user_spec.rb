require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :user_parties }
    it { should have_many :viewing_parties }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_uniqueness_of(:email) }
    it { should have_secure_password }
  end

  describe 'password storage' do
    it 'stores encrypted passwords only' do
      user = User.create!(
        name: 'Sam',
        email: 'sam@test.com',
        password: 'test123',
        password_confirmation: 'test123'
      )

      expect(user).to_not have_attribute :password
      expect(user.password_digest).to_not eq 'test123'
    end
  end
end
