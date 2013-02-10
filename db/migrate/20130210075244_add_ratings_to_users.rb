class AddRatingsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :driver_rating, :decimal, limit: 5.0
    add_column :users, :person_rating, :decimal, limit: 5.0
  end
end
