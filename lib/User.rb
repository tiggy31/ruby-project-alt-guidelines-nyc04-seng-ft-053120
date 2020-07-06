class User < ActiveRecord::Base

    has_many  :recipes

    has_many  :drinks, through: :recipes

   def self.create_a_new_user_please
        prompt = TTY::Prompt.new
      username =  prompt.ask("What do you want your username to be?")
        if User.find_by(name: username)
          puts "Sorry, the name has been taken"
      else 
        User.create(name: username)
    end
  end

   def self.logging_someone_in
    prompt = TTY::Prompt.new
    username = prompt.ask("what is your username?")
   found_user = User.find_by(name: username) 
      if found_user
        return found_user
      else 
        puts "Sorry, looks like you need a new username! :/"
           sleep(3)
        self.create_a_new_user_please
    end    
  end 

   def self.search_drinks
    prompt = TTY::Prompt.new
    search_drink = prompt.ask("what drink would you like?")
     Drink.all.find do |drink| 
      drink.name == search_drink
      self.ingredientsper(drink.id)
      puts "hello"
      
    end
   end

def self.ingredientsper(input)
  Recipe.all.select do |rec|
   rec.drink_id == input
      rec
   binding.pry
  end
end


end
# else
#     while !founduser
#       puts" try again?"
#       TTY::promt (yes or no)
#       if promp == yes
#          self.logging_someone_on
#       else
#        return to main menu
#  etc