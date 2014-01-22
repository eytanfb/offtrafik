class CreateFrequentPostings < ActiveRecord::Migration
  def change
    create_table :frequent_postings do |t|
      t.date :last_date
      t.string :from_address
      t.string :to_address
      t.boolean :smoking
      t.text :comments
      t.string :driving
      t.time :starting_time
      t.time :ending_time
      t.integer :user_id

      t.timestamps
    end
  end
end
