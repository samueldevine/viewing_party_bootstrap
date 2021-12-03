class MovieFacade

  def top_rated
    MovieRepo.new(service.top_rated)
  end

  def search(query)
    MovieRepo.new(service.search(query))
  end

  def movie_details(movie_id)
    Movie.new(service.movie_details(movie_id))
  end

  def cast_list
  end

  def reviews
  end

  def party_details(viewing_parties)
    viewing_parties.map do |party|
      [party, movie_details(party.movie_id)]
    end
  end

  private
  def service
    MovieService.new
  end
end
