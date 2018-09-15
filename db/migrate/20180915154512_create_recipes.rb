class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :description
      t.string :serving_size
      t.integer :cook_time
      t.integer :prep_time
      t.string :ingredients
      t.string :instructions
    end
  end
end
