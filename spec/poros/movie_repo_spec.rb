require 'rails_helper'

RSpec.describe 'Movie' do
  it 'exists' do
    data = { results: [
      { id: 1, title: 'Inception', genres: 'Thriller', overview: 'Dream inside a dream', vote_count: 1, vote_average: 10,
        runtime: 243, poster_path: 'https://www.linkedin.com/in/christian-valesares/' }, { id: 2, title: 'Not Inception', genres: 'Not a Thriller', overview: 'Not a Dream inside a dream', vote_count: 100, vote_average: 0, runtime: 23, poster_path: 'https://www.linkedin.com/in/samueldevine/' }
    ] }
    repo = MovieRepo.new(data)

    expect(repo).to be_an_instance_of(MovieRepo)
  end

  it 'is a collection of movies' do
    data = { results: [
      { id: 1, title: 'Inception', genres: 'Thriller', overview: 'Dream inside a dream', vote_count: 1, vote_average: 10,
        runtime: 243, poster_path: 'https://www.linkedin.com/in/christian-valesares/' }, { id: 2, title: 'Not Inception', genres: 'Not a Thriller', overview: 'Not a Dream inside a dream', vote_count: 100, vote_average: 0, runtime: 23, poster_path: 'https://www.linkedin.com/in/samueldevine/' }
    ] }
    repo = MovieRepo.new(data)

    expect(repo.all).to be_an Array
    expect(repo.all.first).to be_a Movie
  end
end
