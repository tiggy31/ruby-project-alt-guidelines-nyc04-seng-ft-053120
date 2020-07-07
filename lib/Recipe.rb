class Recipe < ActiveRecord::Base


    belongs_to :user
    belongs_to :drink
    # has_many :ingredients


    def self.find_recipe_ingredients(passed_drink_id)
        Recipe.all.find do |recipe|
          return recipe.ingredients if recipe.drink_id == passed_drink_id
        end
      end

    end