load 'funcs.rb'

puts "Steam64 ID'nizi veya özel steam url'nizin sonunda yazan id'yi giriniz.."
input = gets.chomp
data = getuserdata(input)
user_name = data[0]
game_name = data[1]
status = data[2]
color = data [3]
avatar_url = data[4]
color_magic = data[5]

draw(user_name, avatar_url, status, color, color_magic)
