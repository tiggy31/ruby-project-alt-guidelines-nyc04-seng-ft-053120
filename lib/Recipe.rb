class Recipe < ActiveRecord::Base


    belongs_to :user
    belongs_to :drink
    has_many :ingredients
end