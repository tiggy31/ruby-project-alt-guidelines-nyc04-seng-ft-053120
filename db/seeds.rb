gem 'faker'
User.destroy_all
Drink.destroy_all
Recipe.destroy_all
  #USER FILE
ali = User.find_or_create_by(name: "Ali", age: 13)
Bill = User.find_or_create_by(name: "Bill", age: 15)
Sandy = User.find_or_create_by(name: "Sandy", age: 20)
Dan = User.find_or_create_by(name: "Dan", age: 21)
Kara = User.find_or_create_by(name: "Kara", age: 39)
Duri= User.find_or_create_by(name: "Duri", age: 30)
Melat = User.find_or_create_by(name: "Melat", age: 35)
Meron = User.find_or_create_by(name: "Meron", age: 50)
Yosef = User.find_or_create_by(name: "Yosef", age: 27)
Teki = User.find_or_create_by(name: "Teki", age: 69)
Phillip = User.find_or_create_by(name: "Phillip", age: 29)
Mike= User.find_or_create_by(name: "Mike", age: 33)
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


Recipe.find_or_create_by(user_id: kali.id, drink_id: agentorange.id,"Pour it all")
# t.integer :user_id
# t.integer :drink_id
# t.string  :ingredients





