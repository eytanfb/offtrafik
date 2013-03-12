class AddSmokingToPostingAndDropItFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :smoking
    add_column :postings, :smoking, :boolean
  end
end
