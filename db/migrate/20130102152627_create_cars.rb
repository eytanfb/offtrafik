class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :owner
      t.integer :capacity

      t.timestamps
    end
  end
end
