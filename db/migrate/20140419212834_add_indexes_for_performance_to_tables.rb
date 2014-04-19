class AddIndexesForPerformanceToTables < ActiveRecord::Migration
  def change
    add_index :comments, :user_id
    add_index :favorites, :user_id
    add_index :frequent_postings, :user_id
    add_index :postings, :user_id
    add_index :frequent_days, :frequent_posting_id
    add_index :neighborhoods, :district_id
    add_index :posting_responses, :posting_id
  end
end
