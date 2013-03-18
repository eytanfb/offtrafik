class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :agreed_to_terms_and_conditions, :boolean
  end
end
