class CreateResult < ActiveRecord::Migration[7.0]
  def change
    create_table :results do |t|
      t.integer :input, null: false, unique: true
      t.integer :result, array: true, null: false
      t.timestamps
    end
  end
end
