require_relative '../config/environment'
class User < ActiveRecord::Base

  has_many  :recipes
  has_many  :drinks, through: :recipes

  def self.create_a_new_user_please
    prompt = TTY::Prompt.new
    username =  prompt.ask("What do you want your username to be?")
    if User.find_by(name: username)
      puts "Sorry, the name has been taken"
    else
      User.create(name: username)
      puts "You are registered!!"
    end
  end

  def self.logging_someone_in
    prompt = TTY::Prompt.new
    username = prompt.ask("What's your username?")
    found_user = User.find_by(name: username)
    if found_user
      return found_user
    else
        puts "Sorry, looks like you need a new username! :/"
           sleep(3)
        self.create_a_new_user_please
    end
  end

end
