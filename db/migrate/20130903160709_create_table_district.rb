class CreateTableDistrict < ActiveRecord::Migration
  def up
    create_table :districts do |t|
      t.string :name

      t.timestamps
    end
    
  end

  def down
  end
end