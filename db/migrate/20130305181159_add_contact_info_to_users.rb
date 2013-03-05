class AddContactInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :preferred_contact_method, :string
    add_column :users, :preferred_contact_content, :string
  end
end
