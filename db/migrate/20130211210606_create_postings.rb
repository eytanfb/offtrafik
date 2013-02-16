class CreatePostings < ActiveRecord::Migration
  def change
    create_table :postings do |t|
      t.string :from_address
      t.string :to_address
      t.integer :price
      t.integer :user_id
      t.date :date
      t.time :starting_time
      t.time :ending_time

      t.timestamps
    end
  end
end
