class AddTableFavorites < ActiveRecord::Migration
  def up
    create_table :favorites do |t|
      t.integer :user_id
      t.string :location

      t.timestamps
    end
  end

  def down
  end
end
