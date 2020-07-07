require_relative '../config/environment'
class Drink < ActiveRecord::Base


    has_many :recipes
    has_many :users, through: :recipes

    def self.find_drink_id(user_input)
      Drink.all.find do |drink|
        return drink.id if drink.name == user_input
      end
    end

    def self.find_created_by(user_name)
      Drink.all.filter_map do |drink|
        drink.name if drink.created_by == user_name
    end
  end

  def self.delete_cocktail(chosen_drink)
    Drink.all.find do |drink|
       drink.destroy if drink.name == chosen_drink
    end
  end

  def self.rename_my_concoctions(selected_drink, updated_name, user_name)
     Drink.all.each do |drink|
      if drink.name == selected_drink && drink.created_by == user_name
        drink.name = updated_name
        drink.save
      end
    end
  end

end
