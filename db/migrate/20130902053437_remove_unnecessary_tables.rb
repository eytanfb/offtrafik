class RemoveUnnecessaryTables < ActiveRecord::Migration
  def up
    drop_table :people
    drop_table :rates
    drop_table :rating_caches
  end

  def down
  end
end
