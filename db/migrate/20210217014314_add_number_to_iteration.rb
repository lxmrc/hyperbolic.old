class AddNumberToIteration < ActiveRecord::Migration[6.1]
  def change
    add_column :iterations, :number, :integer, default: 1
  end
end
