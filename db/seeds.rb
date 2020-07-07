require 'faker'
User.destroy_all
Drink.destroy_all
Recipe.destroy_all
  #USER FILE
ali = User.find_or_create_by(name: "Ali", age: 13)
bill = User.find_or_create_by(name: "Bill", age: 15)
sandy = User.find_or_create_by(name: "Sandy", age: 20)
dan = User.find_or_create_by(name: "Dan", age: 21)
kara = User.find_or_create_by(name: "Kara", age: 39)
duri= User.find_or_create_by(name: "Duri", age: 30)
melat = User.find_or_create_by(name: "Melat", age: 35)
meron = User.find_or_create_by(name: "Meron", age: 50)
yosef = User.find_or_create_by(name: "Yosef", age: 27)
teki = User.find_or_create_by(name: "Teki", age: 69)
phillip = User.find_or_create_by(name: "Phillip", age: 29)
mike= User.find_or_create_by(name: "Mike", age: 33)
jojo = User.find_or_create_by(name: "Jojo", age: 65)
miran = User.find_or_create_by(name: "Miran", age: 55)
kali = User.find_or_create_by(name: "Kali", age: 44)

# t.string :name
# t.boolean :alcohol
# t.string :category

agentorange = Drink.find_or_create_by(name: "Agent Orange", alcohol: 1 ,category: "Vodka")
aviation = Drink.find_or_create_by(name: "Aviation", alcohol: 1 ,category: "Gin")
nixon = Drink.find_or_create_by(name: "Nixon", alcohol: 1 ,category: "Whiskey")
margarita = Drink.find_or_create_by(name: "Margarita", alcohol: 1 ,category: "Cocktail")
sourwhiskey = Drink.find_or_create_by(name: "Sour Whiskey", alcohol: 1 ,category: "Whiskey")
virgin_pinacolada = Drink.find_or_create_by(name: "Pina Colada", alcohol: 0 ,category: "Virgin")
oldfashion = Drink.find_or_create_by(name: "Old Fashion", alcohol: 1 ,category: "Whiskey")


Recipe.create(user_id: kali.id, drink_id: agentorange.id, ingredients: "Pour")
Recipe.create(user_id: jojo.id, drink_id: aviation.id, ingredients: "1 1/2 oz Gin, 1/2 oz Lemon juice, 1/2 oz Maraschino liqueur, Crème de violette or Creme Yvette.
Add all ingredients into cocktail shaker filled with ice. Shake well and strain into cocktail glass. Garnish with a cherry.")
Recipe.create(user_id: mike.id, drink_id: margarita.id, ingredients: "drink,drink,drink")
Recipe.create(user_id: melat.id, drink_id: nixon.id, ingredients: "crystal")
Recipe.create(user_id: teki.id, drink_id: sourwhiskey.id, ingredients: "brush brush brush")
# t.integer :user_id
# t.integer :drink_id
# t.string  :ingredients





puts "Done seeding!"
