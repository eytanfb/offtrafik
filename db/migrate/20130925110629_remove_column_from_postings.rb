class RemoveColumnFromPostings < ActiveRecord::Migration
  def up
    remove_column :postings, :latitude
  end

  def down
    add_column :postings, :latitude, :string
  end
end
