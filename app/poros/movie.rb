class Movie
  attr_reader :id,
              :title,
              :genres,
              :overview,
              :vote_count,
              :vote_average,
              :runtime,
              :poster_path

  def initialize(info)
    @id           = info[:id]
    @title        = info[:title]
    @genres       = info[:genres]
    @overview     = info[:overview]
    @vote_count   = info[:vote_count]
    @vote_average = info[:vote_average]
    @runtime      = info[:runtime]
    @poster_path  = info[:poster_path]
  end
end
