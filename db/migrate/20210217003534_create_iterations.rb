class CreateIterations < ActiveRecord::Migration[6.1]
  def change
    create_table :iterations do |t|
      t.references :exercise, null: false, foreign_key: true
      t.datetime :completed_at

      t.timestamps
    end
  end
end
