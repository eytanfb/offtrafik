class AddGmapsToPosting < ActiveRecord::Migration
  def change
    add_column :postings, :longitude, :float
    add_column :postings, :latitude, :float
    add_column :postings, :gmaps, :boolean
  end
end
