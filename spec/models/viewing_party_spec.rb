require 'rails_helper'

RSpec.describe ViewingParty, type: :model do
  describe 'relationships' do
    it { should have_many :user_parties }
    it { should have_many :users}
  end

  describe 'validations' do
    it { should validate_presence_of(:movie_id) }
    it { should validate_presence_of(:host_id) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:start_time) }
  end

  describe 'class methods' do
    describe '::find_by_user' do
      it 'returns all viewing parties that a given user is participating in' do
        bob = User.create!(name: 'Bob Belcher', email: 'bburger@yahoo.com')
        linda = User.create!(name: 'Linda Belcher', email: 'lbecher@yahoo.com')
        party_1 = bob.viewing_parties.create!(movie_id: 550, host_id: bob.id, start_time: '18:00', date: '2022-Jan-01')
        party_2 = bob.viewing_parties.create!(movie_id: 551, host_id: bob.id, start_time: '12:00', date: '2021-Dec-16')
        party_3 = linda.viewing_parties.create!(movie_id: 552, host_id: linda.id, start_time: '13:00', date: '2021-Dec-17')
        party_4 = linda.viewing_parties.create!(movie_id: 553, host_id: linda.id, start_time: '14:00', date: '2021-Dec-18')
        party_3.users << bob

        expect(ViewingParty.find_by_user(bob)).to be_an ActiveRecord::Relation
        expect(ViewingParty.find_by_user(bob).first).to be_a ViewingParty
        expect(ViewingParty.find_by_user(bob)).to include party_1
        expect(ViewingParty.find_by_user(bob)).to include party_2
        expect(ViewingParty.find_by_user(bob)).to include party_3
        expect(ViewingParty.find_by_user(bob)).to_not include party_4
      end
    end
  end
end
