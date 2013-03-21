class AddColumnsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :text, :string
    add_column :comments, :rating, :integer
  end
end
