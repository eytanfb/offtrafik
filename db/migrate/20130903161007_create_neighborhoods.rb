class CreateNeighborhoods < ActiveRecord::Migration
  def up
    create_table :neighborhoods do |t|
      t.integer :district_id
      t.string :name
      
      t.timestamps
    end
  end

  def down
  end
end
