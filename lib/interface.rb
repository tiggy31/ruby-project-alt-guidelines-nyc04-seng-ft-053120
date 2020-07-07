require_relative '../config/environment'
class Interface
  attr_accessor :prompt, :user, :drink, :recipe

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
        menu.choice "Close app.", -> { next }
    end
  end

  def show_ingredients(created_drink_ingredients)
    # binding.pry
    puts "Here you go, the recipe and directions for your drink!"
    puts created_drink_ingredients
    sleep(3)
    main_menu
  end

  def find_drink_prompt(prompt_question, name_of_creator)
    prompt = @prompt
    my_concoction = Drink.find_created_by(name_of_creator)
    main_menu if my_concoction == nil
    selected_drink = prompt.select(prompt_question, my_concoction)
  end

  def see_all_my_created_drinks(name_of_creator)
    selected_drink = find_drink_prompt("Here are your own concoctions. Which one do you want to check?", name_of_creator)
    selected_drink_id = Drink.find_drink_id(selected_drink)
    created_drink_ingredients = Recipe.find_recipe_ingredients(selected_drink_id)
    show_ingredients(created_drink_ingredients)
  end

  def delete_my_drink(name_of_creator)
    selected_drink = find_drink_prompt("Here are your own concoctions. Which one do you want to check?", name_of_creator)
    Drink.delete_cocktail(selected_drink)
    puts "The cocktail has been deleted"
    main_menu
  end

  def update_cocktail_name(name_of_creator)
    selected_drink = find_drink_prompt("Here are your concoctions. Which one do you want to rename?", name_of_creator)
    updated_name = prompt.ask("What is the new name of your drink? ")
    Drink.rename_my_concoctions(selected_drink, updated_name, name_of_creator)
    puts "The cocktails name is now #{updated_name}"
    main_menu
  end

  def update_cocktail_ingredients(name_of_creator)
    selected_drink = find_drink_prompt("Here are your concoctions. Which one do you want to update?", name_of_creator)
    updated_ingredients = prompt.ask("How is it made? ")
    selected_drink_id = Drink.find_drink_id(selected_drink)
    Recipe.new_cocktail_ingredients(selected_drink_id, updated_ingredients)
    main_menu
  end

  def search_for_a_drink
    prompt = @prompt
    requested_drink = prompt.ask("Name your poison.")
    requested_drink_id = Drink.find_drink_id(requested_drink)
    recipe_ingredients = Recipe.find_recipe_ingredients(requested_drink_id)
    show_ingredients (recipe_ingredients)
  end

  def create_a_new_drink
    prompt = @prompt
    new_drink_name = prompt.ask("What is the name of your drink? ")
    new_drink = Drink.create({name:new_drink_name , created_by:user.name })
    new_drink_ingredients = prompt.ask("Alright, how do you make it?")
    Recipe.create ({user_id: user.id, drink_id: new_drink.id, ingredients: new_drink_ingredients })
    main_menu
  end

end
