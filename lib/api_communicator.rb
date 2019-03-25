require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  match = find_character_by_name(character_name)
  match["films"].map{|film| JSON.parse(RestClient.get(film))}
end

def characters_hash_from_api
  JSON.parse(RestClient.get('http://www.swapi.co/api/people/'))
end

def find_character_by_name(character_name)
  characters_hash_from_api["results"].find{|character| character["name"].downcase == character_name}
end

def print_movies(films)
  sorted_films = films.sort_by{|film| film['episode_id']}
  sorted_films.each do |film|
    puts "Star Wars Episode #{film['episode_id']}"
    puts "#{film['title']}"
    puts "Release date: #{film['release_date']}"
    puts "Directed By: #{film['director']}"
    puts "~"*30
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end
