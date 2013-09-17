class AddActivationColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active, :integer
    add_column :users, :activation_guid, :string
  end
end
