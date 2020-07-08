require_relative '../config/environment'
require 'open-uri'
require 'net/http'
require 'json'

class Interface
  attr_accessor :prompt, :user

  def initialize
    @prompt = TTY::Prompt.new
  end

  def welcome
    puts "Hello! welcome to my app"
  end

  def choose_login_or_register
    answer = prompt.select("Are you logging in or registering?", ["Logging in", "Registering"])
    answer == "Logging in" ? User.logging_someone_in : User.create_a_new_user_please
  end

  def main_menu
      prompt.select("Hey #{user.name}! What would you like to do?") do |menu|
        menu.choice "Search for a cocktail/drink.",  -> { self.search_for_a_drink }
        menu.choice "Create a new cocktail/drink.", -> { self.create_a_new_drink }
        menu.choice "Checks my created cocktails/drinks", -> { self.see_all_my_created_drinks(user.name) }
        menu.choice "Delete my created drinks", -> {self.delete_my_drink(user.name)}
        menu.choice "Update created cocktail name", -> {self.update_cocktail_name(user.name)}
        menu.choice "Update created cocktail ingredients", -> {self.update_cocktail_ingredients(user.name)}
        menu.choice "Close app.", -> { }
    end
  end

  def show_ingredients(string)
    puts "Here you go, the recipe and directions for your drink!"
    puts string
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
      puts "Sorry, you havent created anything yet"
      main_menu
    else
    selected_drink = find_drink_prompt("Here are your own concoctions. Which one do you want to check?", name_of_creator)
    selected_drink_id = Drink.find_drink_id(selected_drink)
    created_drink_ingredients = Recipe.find_recipe_ingredients(selected_drink_id)
    show_ingredients(created_drink_ingredients)
    end
  end

  def delete_my_drink(name_of_creator)
    value_check = Drink.find_by created_by: name_of_creator
    if value_check == nil
      puts "Sorry, you havent created anything yet"
      main_menu
    else
      selected_drink = find_drink_prompt("Here are your own concoctions. Which one do you want to check?", name_of_creator)
      Drink.delete_cocktail(selected_drink)
      puts "The cocktail has been deleted"
    end
  end

  def update_cocktail_name(name_of_creator)
    value_check = Drink.find_by created_by: name_of_creator
    if value_check == nil
      puts "Sorry, you havent created anything yet"
      main_menu
    else
      selected_drink = find_drink_prompt("Here are your concoctions. Which one do you want to rename?", name_of_creator)
      updated_name = prompt.ask("What is the new name of your drink? ")
      Drink.rename_my_concoctions(selected_drink, updated_name, name_of_creator)
      puts "The cocktails name is now #{updated_name}"
    end
  end

  def update_cocktail_ingredients(name_of_creator)
    value_check = Drink.find_by created_by: name_of_creator
    if value_check == nil
      puts "Sorry, you havent created anything yet"
      main_menu
    else
      selected_drink = find_drink_prompt("Here are your concoctions. Which one do you want to update?", name_of_creator)
      updated_ingredients = prompt.ask("How is it made? ")
      selected_drink_id = Drink.find_drink_id(selected_drink)
      Recipe.new_cocktail_ingredients(selected_drink_id, updated_ingredients)
    end
  end

  def search_for_a_drink
    prompt = @prompt
    requested_drink = prompt.ask("Name your poison.")
    url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{requested_drink}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    response.body
pp JSON.parse(response.body)
  end

  def search_for_a_drink
  prompt = @prompt
  requested_drink = prompt.ask("Name your poison.")
  value_check = Drink.find_by name: requested_drink
    if value_check == nil
      puts "Sorry we dont have that in our database"
      sleep(2)
      main_menu
    else
      requested_drink_id = Drink.find_drink_id(requested_drink)
      recipe_ingredients = Recipe.find_recipe_ingredients(requested_drink_id)
      show_ingredients (recipe_ingredients)
  end
end



end
