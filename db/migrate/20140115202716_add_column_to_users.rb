class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :neighborhoog, :string
  end
end
