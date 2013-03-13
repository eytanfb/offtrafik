class AddColumnDriverToPostings < ActiveRecord::Migration
  def change
    add_column :postings, :driving, :boolean
  end
end
