class ChangeColumnDrivingInPostings < ActiveRecord::Migration
  def up
    change_column :postings, :driving, :string
  end

  def down
  end
end
