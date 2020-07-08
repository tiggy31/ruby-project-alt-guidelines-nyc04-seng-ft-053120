require_relative '../config/environment'
class Recipe < ActiveRecord::Base


    belongs_to :user
    belongs_to :drink


    def self.find_recipe_ingredients(passed_drink_id)
      Recipe.all.find do |recipe|
        return recipe.ingredients if recipe.drink_id == passed_drink_id
      end
    end

    def self.new_cocktail_ingredients(selected_drink_id, updated_ingredients )
      Recipe.all.each do |recipe|
        if recipe.drink_id == selected_drink_id
          recipe.ingredients = updated_ingredients
          recipe.save
        end
      end
    end

end
