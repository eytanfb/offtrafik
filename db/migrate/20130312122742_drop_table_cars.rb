class DropTableCars < ActiveRecord::Migration
  def up
    drop_table :cars
  end

  def down
  end
end
