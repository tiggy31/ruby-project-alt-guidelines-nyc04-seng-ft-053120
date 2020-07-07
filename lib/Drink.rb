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

  def update_cocktail
  end

  def self.delete_cocktail(chosen_drink)
    Drink.all.find do |drink|
      # binding.pry
       drink.destroy if drink.name == chosen_drink
    end
  end

end
