class BackToOriginalPostingStructure < ActiveRecord::Migration
  def up
    remove_column :postings, :from_address_neighborhood
    remove_column :postings, :from_address_district
    remove_column :postings, :to_address_neighborhood
    remove_column :postings, :to_address_district
    add_column :postings, :from_address, :string
    add_column :postings, :to_address, :string
  end

  def down
    add_column :postings, :from_address_neighborhood, :string
    add_column :postings, :from_address_district, :string
    add_column :postings, :to_address_neighborhood, :string
    add_column :postings, :to_address_district, :string
    remove_column :postings, :from_address
    remove_column :postings, :to_address
  end
end
