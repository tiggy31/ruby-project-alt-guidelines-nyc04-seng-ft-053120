require_relative '../config/environment'
class Recipe < ActiveRecord::Base


    belongs_to :user
    belongs_to :drink
<<<<<<< HEAD
    # has_many :ingredients


    def self.find_recipe_ingredients(passed_drink_id)
        Recipe.all.find do |recipe|
          return recipe.ingredients if recipe.drink_id == passed_drink_id
        end
      end

    end
=======


    def self.find_recipe_ingredients(passed_drink_id)
      Recipe.all.find do |recipe|
        return recipe.ingredients if recipe.drink_id == passed_drink_id
      end
    end
end
>>>>>>> 3b62369d7eb533f2b4bf9065a5e57f6daf09051a
