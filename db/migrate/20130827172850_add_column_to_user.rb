class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :neighborhood, :string
    add_column :users, :total_kms, :integer
    add_column :users, :summary, :string
  end
end
