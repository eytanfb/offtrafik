class ChangeRatingsFromDecimalToIntegerInUsers < ActiveRecord::Migration
  def up
    change_column :users, :driver_rating, :integer
    change_column :users, :person_rating, :integer
  end

  def down
  end
end
