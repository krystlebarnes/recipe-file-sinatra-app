class ChangeDatatypeForServingSize < ActiveRecord::Migration
  def change
    change_column :recipes, :serving_size, :integer
  end
end
