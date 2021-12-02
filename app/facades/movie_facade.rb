class MovieFacade

  def top_rated
    MovieRepo.new(service.top_rated)
  end

  def search(query)
    MovieRepo.new(service.search(query))
  end

  def movie_details(movie_id)
    MovieRepo.new(service.movie_details(movie_id))
  end

  def cast_list
  end

  def reviews
  end

  private
  def service
    MovieService.new
  end
end
