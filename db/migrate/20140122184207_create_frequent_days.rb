class CreateFrequentDays < ActiveRecord::Migration
  def change
    create_table :frequent_days do |t|
      t.string :day

      t.timestamps
    end
  end
end
