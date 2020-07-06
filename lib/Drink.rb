require_relative '../config/environment'
class Drink < ActiveRecord::Base

    has_many :recipes

    has_many :users, through: :recipes

end
