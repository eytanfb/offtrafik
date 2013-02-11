class AddRatingsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :driver_rating, :decimal, precision: 2, scale: 1
    add_column :users, :person_rating, :decimal, precision: 2, scale: 1
  end
end
