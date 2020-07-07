class CreateSavedDrinks < ActiveRecord::Migration[5.2]
  def change
    add_column :drinks, :created_by, :string
  end
end
