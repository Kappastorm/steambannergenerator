load 'funcs.rb'

def main(input)
  data = getuserdata(input)
  user_name = data[0]
  game_name = data[1]
  status = data[2]
  color = data [3]
  avatar_url = data[4]
  color_magic = data[5]
  game_id = data[6].to_i
  id = data[7]
  if game_id != 0
    gamedata = getgameinfo(id, game_id)
    twoweeks = gamedata[0]
    playtime = gamedata[1]
    logo = gamedata[2]
    if twoweeks == nil
      twoweeks = 0
    end
    twoweeks = "#{twoweeks/60} saat #{twoweeks%60} dakika"
    playtime = "#{playtime/60} saat #{playtime%60} dakika"
    logo_url = "http://media.steampowered.com/steamcommunity/public/images/apps/" + game_id.to_s + "/" + logo + ".jpg"
    info = "Son iki haftada                       Toplam\n#{twoweeks} oynandi!    #{playtime} oynandi!"
  end
  draw(user_name, avatar_url, status, color, color_magic, info, logo_url)
  return id,status
end
#Start
puts "Steam64 ID'nizi veya özel steam url'nizin sonunda yazan id'yi giriniz.."
input = gets.chomp
statid = main(input)
id = statid[0]
status = statid[1]
puts  "Badge oluşturuldu!"
loop do
  new_status = getuserdata(id)[2]
  if status != new_status
    main(input)
    status = new_status
    puts "Badge güncellendi!"
  else
    sleep(5)
  end
end
