class RemovePriceFromPostings < ActiveRecord::Migration
  def up
    remove_column :postings, :price
  end
end
