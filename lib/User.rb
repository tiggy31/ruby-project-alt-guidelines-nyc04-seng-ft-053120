class User < ActiveRecord::Base

    has_many  :recipes

    has_many  :drinks, through: :recipes


end