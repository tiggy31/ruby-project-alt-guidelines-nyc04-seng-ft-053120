class CreateDrinksTable < ActiveRecord::Migration[5.2]
  def change
      create_table :drinks do |t|
        t.string :name
        t.boolean :alcohol
        t.string :category
        t.timestamps
      end
   end
end
