class AddColumnToComments < ActiveRecord::Migration
  def change
    add_column :comments, :is_about, :integer
  end
end
