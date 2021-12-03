class MovieFacade
  class << self

  def top_rated
    MovieRepo.new(MovieService.top_rated)
  end

  def search(query)
    MovieRepo.new(MovieService.search(query))
  end

  def movie_details(movie_id)
    Movie.new(MovieService.movie_details(movie_id))
  end

  def cast_list(movie_id)
    MovieService.cast_list(movie_id)[:cast].map do |member_data|
      CastMember.new(member_data)
    end[0..9]
  end

  def reviews(movie_id)
    MovieService.reviews(movie_id)[:results].map do |review_data|
      Review.new(review_data)
    end
  end

  def party_details(viewing_parties)
    viewing_parties.map do |party|
      [party, movie_details(party.movie_id)]
    end
  end

  end
end
