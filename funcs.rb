require 'steam-condenser'
require 'chunky_png'
require 'open-uri'
require 'JSON'
require "mini_magick"

def getuserdata(url_or_id)
if url_or_id.to_i == 0
  id = SteamId.new(url_or_id).steam_id64
elsif url_or_id.to_i != 0
  id = url_or_id
end
open("http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=72ACA800DA8DBDB5DF8A20CAD290673D&steamids=#{id}", "r") do |f|
contents = JSON.parse(f.read.to_s)["response"]["players"][0]
name = contents["personaname"]
game_name = contents["gameextrainfo"]
game_id = contents["gameid"]
avatar_url = contents["avatarmedium"]
case contents["personastate"]
when 0
  status = "Çevrimdışı"
  color = ChunkyPNG::Color::rgb(107,107,107)
  color_magic = "rgb(107,107,107)"
when 1
  status = "Çevrimiçi"
  color = ChunkyPNG::Color::rgb(84,165,197)
  color_magic = "rgb(84,165,197)"
when 2
  status = "Meşgul"
  color = ChunkyPNG::Color::rgb(140,16,16)
  color_magic = "rgb(140,16,16)"
when 3
  status = "Dışarıda"
  color = ChunkyPNG::Color::rgb(255,195,0)
  color_magic = "rgb(255,195,0)"
when 4
  status = "Uykuda"
  color = ChunkyPNG::Color::rgb(255,195,0)
  color_magic = "rgb(255,195,0)"
when 5
  status = "Takas yapmak istiyor"
  color = ChunkyPNG::Color::rgb(84,165,197)
  color_magic = "rgb(84,165,197)"
when 6
  status = "Oyun oynamak istiyor"
  color = ChunkyPNG::Color::rgb(84,165,197)
  color_magic = "rgb(84,165,197)"
end
if game_name != nil
  status = "Oyunda\n#{game_name}"
  color = ChunkyPNG::Color::rgb(144,186,60)
  color_magic = "rgb(144,186,60)"
end
return name,game_name,status,color,avatar_url,color_magic
end
end

def draw(name, avatar_url, status, color, color_magic)
  image = MiniMagick::Image.open(avatar_url)
  image.format "png"
  image.write("#{name}.png")
  main = ChunkyPNG::Image.from_file('base.png')
  avatar  = ChunkyPNG::Image.from_file("#{name}.png")
  main.rect(17, 15, 86, 84, ChunkyPNG::Color::TRANSPARENT, color)
  main.compose!(avatar, 20, 18)
  main.save("#{name}result.png")
  img = MiniMagick::Image.open("#{name}result.png")
  img.combine_options do |c|
    c.gravity 'West'
    c.pointsize '22'
    c.font "Roboto-Regular.ttf"
    c.fill(color_magic)
    c.draw "text 95,-45 \"#{name}\""
    c.fill(color_magic)
    c.draw "text 95,-10 \"#{status}\""
  end
  img.write("#{name}result.png")
end
