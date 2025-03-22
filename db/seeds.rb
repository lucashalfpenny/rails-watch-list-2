# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'uri'
require 'net/http'
require 'json'
require 'dotenv/load'
require 'faker'

puts "Cleaning the database..."
Movie.destroy_all
Bookmark.destroy_all
List.destroy_all
puts "Database wiped!"

api_key = ENV["API_KEY"]
access_token = ENV["ACCESS_TOKEN"]
url = URI("https://api.themoviedb.org/3/movie/top_rated?api_key=#{api_key}")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["Authorization"] = "Bearer #{access_token}"

response = http.request(request)
films = JSON.parse(response.body)
films = films["results"].map do |film|
  film = Movie.create!(
    title: film["title"],
    overview: film["overview"],
    poster_url: film["backdrop_path"],
    rating: film["vote_average"]
  )
  puts "#{film["title"]} created!"
end

puts "You have created #{films.count} films!!"

# 3.times do
#   List.create(name: Faker::Name.name)
# end
