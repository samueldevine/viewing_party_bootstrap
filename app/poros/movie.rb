class Movie
  attr_reader :title,
              :genres,
              :overview,
              :vote_count,
              :vote_average,
              :runtime
              
  def initialize(info)
    @title = info[:title]
    @genres = info[:genres]
    @overview = info[:overview]
    @vote_count = info[:vote_count]
    @vote_average = info[:vote_average]
    @runtime = info[:runtime]
  end
end
