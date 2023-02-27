class Movie
  attr_reader :director

  def initialize(name, director, year)
    @name = name
    @director = director
    @year = year
  end

  def to_s
    "#{@director} - #{@name} (#{@year})"
  end
end
