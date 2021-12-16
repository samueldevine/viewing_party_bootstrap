require 'rails_helper'

RSpec.describe 'Movie' do
  it 'exists' do
    movie = Movie.new(id: 1, title: 'Inception', genres: 'Thriller', overview: 'Dream inside a dream', vote_count: 1,
                      vote_average: 10, runtime: 243, poster_path: 'https://www.linkedin.com/in/christian-valesares/')

    expect(movie).to be_an_instance_of(Movie)
  end
  it 'has attributes' do
    movie = Movie.new(id: 1, title: 'Inception', genres: 'Thriller', overview: 'Dream inside a dream', vote_count: 1,
                      vote_average: 10, runtime: 243, poster_path: 'https://www.linkedin.com/in/christian-valesares/')

    expect(movie.id).to eq(1)
    expect(movie.title).to eq('Inception')
    expect(movie.genres).to eq('Thriller')
    expect(movie.overview).to eq('Dream inside a dream')
    expect(movie.vote_count).to eq(1)
    expect(movie.vote_average).to eq(10)
    expect(movie.runtime).to eq(243)
    expect(movie.poster_path).to eq('https://www.linkedin.com/in/christian-valesares/')
  end
end
