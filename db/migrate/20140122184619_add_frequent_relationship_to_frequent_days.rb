class AddFrequentRelationshipToFrequentDays < ActiveRecord::Migration
  def change
    add_column :frequent_days, :frequent_posting_id, :integer
  end
end
