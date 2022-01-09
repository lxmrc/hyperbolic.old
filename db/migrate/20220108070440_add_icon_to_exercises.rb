class AddIconToExercises < ActiveRecord::Migration[6.1]
  def change
    add_column :exercises, :icon, :string
  end
end
