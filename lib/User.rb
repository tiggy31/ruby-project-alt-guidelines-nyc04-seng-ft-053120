require_relative '../config/environment'
class User < ActiveRecord::Base

  has_many  :recipes
  has_many  :drinks, through: :recipes

  def self.create_a_new_user_please
    prompt = TTY::Prompt.new
    (username =  prompt.ask("What do you want your username to be?")).capitalize!
    if User.find_by(name: username)
      puts "Sorry, the name has been taken"
    else
      new_user = User.create(name: username)
      prompt = TTY::Prompt.new
      new_user_age =  prompt.ask("Great! How old are you #{new_user.name}?")
      new_user.age = new_user_age
      new_user.save
      puts "You are registered!"
    end
  end

  def self.logging_someone_in
    prompt = TTY::Prompt.new
    (username = prompt.ask("What's your username?")).capitalize!
    found_user = User.find_by(name: username)
    if found_user
      return found_user
    else
      choices = {"try logging in again?" => true, "create a new account?" => false}
      prompt = prompt.select("Sorry about that, it seems like we cant find you. Do you wanto to ", choices)
      prompt ? self.logging_someone_in : self.create_a_new_user_please
    end
  end

end
