require 'rails_helper'

RSpec.describe Review do
  it 'exists' do
    review = Review.new(author: 'movieguy', content: 'It was pretty good')

    expect(review).to be_a Review
  end

  it 'has readable attributes' do
    review = Review.new(author: 'moviegirl', content: 'my mom hated it')

    expect(review.author).to eq 'moviegirl'
    expect(review.content).to eq 'my mom hated it'
  end
end
