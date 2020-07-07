require_relative '../config/environment'
interface = Interface.new()
interface.welcome
user_instance=interface.choose_login_or_register
until user_instance
  user_instance=interface.choose_login_or_register
end
interface.user = user_instance
interface.main_menu
puts "See you around!"
# puts "hello world"
