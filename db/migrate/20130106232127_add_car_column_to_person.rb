class AddCarColumnToPerson < ActiveRecord::Migration
  def up
    add_column :people, :car, :integer
  end
end
