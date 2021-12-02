class MovieRepo
attr_reader :all

  def initialize(info)
    @all = create_movies(info[:results][0..19])
  end

  def create_movies(info)
    info.map do |row|
      Movie.new(row)
    end
  end
end
