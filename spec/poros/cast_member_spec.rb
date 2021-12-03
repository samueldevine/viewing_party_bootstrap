require 'rails_helper'

RSpec.describe CastMember do
  it 'exists' do
    brad = CastMember.new(name: 'Brad Pitt', character: 'Tyler Durden')

    expect(brad).to be_a CastMember
  end

  it 'has a name and a role' do
    brad = CastMember.new(name: 'Brad Pitt', character: 'Tyler Durden')

    expect(brad.name).to eq 'Brad Pitt'
    expect(brad.character).to eq 'Tyler Durden'
  end
end
