class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :capacity
      t.boolean :smoking
      t.integer :user_id

      t.timestamps
    end
  end
end
