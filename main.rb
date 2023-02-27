require_relative 'lib/movie'
require_relative 'lib/movie_collection'
require 'nokogiri'
require 'open-uri'

collection = MovieCollection.from_list
directors = collection.directors

puts 'Программа «Фильм на вечер»'
puts
directors.each_with_index { |director, index| puts "#{index}: #{director}" }
puts 'Фильм какого режиссера вы хотите сегодня посмотреть?'

user_choice = $stdin.gets.to_i

user_director = directors[user_choice]

film_by_director = collection.by_director(user_director)
puts <<~RESULT

  И сегодня вечером рекомендую посмотреть:
  #{film_by_director.sample}
RESULT
