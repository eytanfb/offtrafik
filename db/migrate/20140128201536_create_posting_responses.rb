class CreatePostingResponses < ActiveRecord::Migration
  def change
    create_table :posting_responses do |t|
      t.integer :responder_id
      t.integer :posting_id
      t.boolean :accepted

      t.timestamps
    end
  end
end
