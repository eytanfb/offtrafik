class FixOwnerColumn < ActiveRecord::Migration
  def up
  end

  def down
  end
  
  def change
    change_table :cars do |column|
      column.rename :owner, :person_id
    end
  end
end
