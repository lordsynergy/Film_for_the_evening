class MovieCollection
  attr_reader :movies, :directors

  # Константа, содержащая адрес для парсинга фильмов
  URL = 'https://ru.wikipedia.org/wiki/250_%D0%BB%D1%83%D1%87%D1%88%D0%B8%D1%85_%D1%84%D0%B8%D0%BB%D1%8C%D0%BC%D0%BE%D0%B2'\
  '_%D0%BF%D0%BE_%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D0%B8_IMDb'.freeze

  # Метод класса, достающий список фильмов из сети
  def self.from_list
    begin
      document = Nokogiri::HTML(URI.open(URL))
    rescue SocketError => e
      puts 'Проверьте интернет соединение.'
      abort e.message
    end

    movies =
      document.xpath('//tr')[1..].map do |element|
        node = element.xpath('td')
        Movie.new(node[1].text, node[3].text.split('(')[0], node[2].text.to_i)
      end

    new(movies)
  end

  # Метод класса, достающий список фильмов из папки
  def self.from_dir(dir_path)
    movie_files = Dir[File.join(dir_path, '*.txt')]

    movies =
      movie_files.map do |file_path|
        film_data = File.readlines(file_path, chomp: true)
        Movie.new(film_data[0], film_data[1], film_data[2])
      end

    new(movies)
  end

  def initialize(movies)
    @movies = movies
    @directors = @movies.map(&:director).uniq
  end

  def by_director(director_name)
    @movies.select { |movie| movie.director == director_name }
  end
end
