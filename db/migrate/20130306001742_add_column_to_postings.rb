class AddColumnToPostings < ActiveRecord::Migration
  def change
    add_column :postings, :comments, :text
  end
end
