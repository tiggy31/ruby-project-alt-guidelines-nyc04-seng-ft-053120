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


  def main_menu
  prompt.select("Hey #{User.name}!!! What would you like to do?") do |menu|
    menu.choice "Search for a cocktail/drink.",  -> { self.search_for_a_drink }
    menu.choice "Create a new cocktail/drink.", -> { }
    menu.choice "See all my created cocktails/drinks", -> {  }
    menu.choice "Close app", ->{self.welcome}
 end
end
  
def search_for_a_drink
  prompt = TTY::Prompt.new
  requested_drink = prompt.ask("Name your poison.")
  requested_drink_id = Drink.find_drink_id(requested_drink)
  recipe_ingredients = Recipe.find_recipe_ingredients(requested_drink_id)
  puts "Hey stranger! Here is the recipe and directions for your drink!"
  puts recipe_ingredients
  sleep(2)
  main_menu
end


def create_a_new_drink
  prompt = TTY::Prompt.new
  new_drink = prompt.ask("What is the name of your drink? ")
  new_drink_title = Drink.create()
 
end

end