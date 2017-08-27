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
    avatar_url = contents["avatarmedium"]
    game_id = contents["gameid"]
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
    return name,game_name,status,color,avatar_url,color_magic,game_id,id
  end
end

def getgameinfo(id, game_id)
  open("http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=72ACA800DA8DBDB5DF8A20CAD290673D&steamid=#{id}&include_appinfo=1&include_played_free_games=1") do |s|
    last_game_data = JSON.parse(s.read.to_s)["response"]["games"]
    last_game_data.each do |k|
      if k["appid"] == game_id
        twoweeks = k["playtime_2weeks"]
        playtime = k["playtime_forever"]
        logo = k["img_logo_url"]
        return twoweeks,playtime,logo
      end
    end
  end
end


def draw(name, avatar_url, status, color, color_magic, info, logo_url)
  image = MiniMagick::Image.open(avatar_url)
  image.format "png"
  image.write("#{name}avatar.png")
  main = ChunkyPNG::Image.from_file('base.png')
  avatar  = ChunkyPNG::Image.from_file("#{name}avatar.png")
  main.rect(17, 15, 86, 84, ChunkyPNG::Color::TRANSPARENT, color)
  main.compose!(avatar, 20, 18)
  if color_magic == "rgb(144,186,60)"
    game_logo = MiniMagick::Image.open(logo_url)
    game_logo.format "png"
    game_logo.resize "122x46"
    game_logo.write("#{name}game.png")
    game_logo = ChunkyPNG::Image.from_file("#{name}game.png")
    main.compose!(game_logo, 17, 95)
    main.save("#{name}result.png")
    main = MiniMagick::Image.open("#{name}result.png")
    main.combine_options do |c|
      c.gravity 'West'
      c.pointsize '14'
      c.font "Roboto-Regular.ttf"
      c.fill("rgb(84,165,197)")
      c.draw "text 150,43 \"#{info}\""
    end
    main.write("#{name}result.png")
  else
    main.save("#{name}result.png")
  end
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
  if color_magic == "rgb(144,186,60)"
    File.delete("#{name}game.png")
  end
  File.delete("#{name}avatar.png")
end
