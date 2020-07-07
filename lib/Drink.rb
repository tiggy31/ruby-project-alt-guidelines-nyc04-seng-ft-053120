class Drink < ActiveRecord::Base

    has_many :recipes 

    has_many :users, through: :recipes
    has_many :recipes
    def self.find_drink_id(user_input)
        Drink.all.find do |drink|
          return drink.id if drink.name == user_input
         end
        end


        
end