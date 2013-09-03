class RemoveLongituteAndLatitudeAndGmapsFromPostings < ActiveRecord::Migration
  def up
    remove_column :postings, :latitiude
    remove_column :postings, :longitude
    remove_column :postings, :gmaps
  end

  def down
  end
end
