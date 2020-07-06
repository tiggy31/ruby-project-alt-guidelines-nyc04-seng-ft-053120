class Interface
  attr_accessor :prompt, :user

 def initialize
    @prompt = TTY::Prompt.new
 end
def welcome
    puts "hello,welcome to my app"

end

def choose_login_or_register
  answer = prompt.select("Are you logging in or registering?", ["Logging in", "Registering"])

   if answer == "Logging in"
     User.logging_someone_in
   elsif answer == "Registering"
     User.create_a_new_user_please
   end
 end

 def main_menue

  puts "Hello, You're here #{self.user.username}"
#prompt.select("Choose your drink, user.drinks")
  # binding.pry
 end

end