class CreateRecipesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.integer :user_id
      t.integer :drink_id
      t.string  :ingredients
      t.timestamps
    end
  end
end
