class ChangeCarsColumnToCarId < ActiveRecord::Migration
  def up
  end

  def down
  end
  
  def change
    rename_column :people, :car, :car_id
  end
end
