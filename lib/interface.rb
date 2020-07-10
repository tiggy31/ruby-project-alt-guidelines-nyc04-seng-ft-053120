require_relative '../config/environment'
require 'open-uri'
require 'net/http'
require 'json'
require 'colorize'
require 'artii'
require 'tty-table'

class Interface
  attr_accessor :prompt, :user, :ani

  def initialize
    @prompt = TTY::Prompt.new
  end

  def welcome
    # Ani.animation
    # sleep(2)
    a = Artii::Base.new :font => 'slant'
    puts a.asciify("Drinks On Me!").colorize(:green)
    puts "Hello! welcome to Drinks On Me!".colorize(:white)
  end

  def choose_login_or_register

    answer = prompt.select("Are you logging in or registering?".colorize(:white), ["Logging in", "Registering"])
    answer == "Logging in" ? User.logging_someone_in : User.create_a_new_user_please
  end

  def main_menu
      prompt.select("Hey #{user.name}! What would you like to do?") do |menu|
        menu.choice "Search for a cocktail/drink.",  -> { self.search_for_a_drink }
        menu.choice "Create a new cocktail/drink.", -> { self.create_a_new_drink }
        menu.choice "See all my created cocktails/drinks", -> { self.see_all_my_created_drinks(user.name) }
        menu.choice "Delete my created drinks", -> {self.delete_my_drink(user.name)}
        menu.choice "Update a created cocktail name", -> {self.update_cocktail_name(user.name)}
        menu.choice "Update a created cocktail ingredients", -> {self.update_cocktail_ingredients(user.name)}
        menu.choice "Close app.", -> { }
    end
  end

  def create_a_new_drink
   prompt = @prompt
   new_drink_name = prompt.ask("What is the name of your drink? ")
   new_drink = Drink.create({name:new_drink_name , created_by:user.name })
   new_drink_ingredients = prompt.ask("Alright, how do you make it?")
   Recipe.create ({user_id: user.id, drink_id: new_drink.id, ingredients: new_drink_ingredients })
   puts "Got,it. Everthing has been saved."
   sleep(1)
   main_menu
 end

  def show_ingredients(string)
    puts "Here you go, the recipe and directions for your cocktail!"
    puts string.colorize(:white)
    sleep(3)
    main_menu
  end

  def find_drink_prompt(prompt_question, name_of_creator)
    prompt = @prompt
    my_concoction = Drink.find_created_by(name_of_creator)
    selected_drink = prompt.select(prompt_question, my_concoction)
  end

  def see_all_my_created_drinks(name_of_creator)
    value_check = Drink.find_by created_by: name_of_creator
    if value_check == nil
      puts "Sorry, looks like you havent made anything yet"
      main_menu
    else
    selected_drink = find_drink_prompt("Here are all of your concoctions. Which one do you want to check?", name_of_creator)
    selected_drink_id = Drink.find_drink_id(selected_drink)
    created_drink_ingredients = Recipe.find_recipe_ingredients(selected_drink_id)
    show_ingredients(created_drink_ingredients)
    end
  end

  def delete_my_drink(name_of_creator)
    value_check = Drink.find_by created_by: name_of_creator
    if value_check == nil
      puts "Sorry, looks like you havent made anything yet"
      main_menu
    else
      selected_drink = find_drink_prompt("Here are your own concoctions. Which one do you want to check?", name_of_creator)
      Drink.delete_cocktail(selected_drink)
      puts "The cocktail has been deleted"
      main_menu
    end
  end

  def update_cocktail_name(name_of_creator)
    value_check = Drink.find_by created_by: name_of_creator
    if value_check == nil
      puts "Sorry, looks like you havent made anything yet"
      main_menu
    else
      selected_drink = find_drink_prompt("Here are your concoctions. Which one do you want to rename?", name_of_creator)
      updated_name = prompt.ask("What is the new name of your drink? ")
      Drink.rename_my_concoctions(selected_drink, updated_name, name_of_creator)
      puts "The cocktails name is now #{updated_name}"
      main_menu
    end
  end

  def update_cocktail_ingredients(name_of_creator)
    value_check = Drink.find_by created_by: name_of_creator
    if value_check == nil
      puts "Sorry, looks like you havent made anything yet"
      main_menu
    else
      selected_drink = find_drink_prompt("Here are your concoctions. Which one do you want to update?", name_of_creator)
      updated_ingredients = prompt.ask("How is it made? ")
      selected_drink_id = Drink.find_drink_id(selected_drink)
      Recipe.new_cocktail_ingredients(selected_drink_id, updated_ingredients)
      main_menu
    end
  end

  def choose_a_drink(drink_array)
    prompt = @prompt
    prompt.select("Alright, this is what I have available.", drink_array)
  end

  def api(drink_requested)
    url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{drink_requested}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    response.body
    JSON.parse(response.body)
  end

  def api_ingredients(selected_drink)
    drink_hash = api(selected_drink)
    drink_converted_hash = {}
    drink_hash.each do |key,value|
    count = 1
      until value[0]["strIngredient#{count}"] == nil
        drink_converted_hash[value[0]["strIngredient#{count}"]] = value[0]["strMeasure#{count}"]
        count += 1
      end
    end
    drink_converted_hash
  end

  def api_instructions(selected_drink)
    drink_hash = api(selected_drink)
    directions = drink_hash["drinks"][0]["strInstructions"]
  end

  def api_directions(selected_drink, selected_drink_ingredients, selected_drink_instructions)
    puts "Got it, you're going to need"
    puts nil
    selected_drink_ingredients.each do |key,value|
      puts " #{value} of #{key}".colorize(:white)
    end
    puts nil
    puts "🍸Here are the directions!🍸"
    puts nil
    puts selected_drink_instructions.colorize(:white)
    puts nil
    prompt = @prompt
    prompt.select("Press enter when you're done", %w(ENTER))
    system "clear"
    main_menu
  end

  def search_for_a_drink
    drink_array = []
    prompt = @prompt
    requested_drink = prompt.ask("Name your poison.")
      if api(requested_drink)["drinks"] == nil
        puts "Sorry im not sure how to make that."
        sleep(2)
        main_menu
      else
        api(requested_drink).each do |key,value|
        value.each do |inner_key|
          #binding.pry
        drink_array << inner_key["strDrink"]
        end
      end
    selected_drink = choose_a_drink(drink_array)
    selected_drink_ingredients = api_ingredients(selected_drink)
    selected_drink_instructions = api_instructions(selected_drink)
    api_directions(selected_drink, selected_drink_ingredients, selected_drink_instructions)
    end
  end
#   def search_for_a_drink
#   prompt = @prompt
#   requested_drink = prompt.ask("Name your poison.")
#   value_check = Drink.find_by name: requested_drink
#     if value_check == nil
#       puts "Sorry we dont have that in our database"
#       sleep(2)
#       main_menu
#     else
#       requested_drink_id = Drink.find_drink_id(requested_drink)
#       recipe_ingredients = Recipe.find_recipe_ingredients(requested_drink_id)
#       show_ingredients (recipe_ingredients)
#   end
# end
end
