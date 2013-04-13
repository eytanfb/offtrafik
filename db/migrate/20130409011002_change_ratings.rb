class ChangeRatings < ActiveRecord::Migration
  def up
    remove_column :users, :driver_rating
    remove_column :users, :person_rating
    add_column :users, :trip_rating, :integer
  end

  def down
  end
end
