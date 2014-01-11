class CreateDatabase < ActiveRecord::Migration
  def up
    create_table "comments", :force => true do |t|
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
      t.string   "text"
      t.integer  "rating"
      t.integer  "is_about"
      t.integer  "user_id"
    end

    create_table "districts", :force => true do |t|
      t.string   "name"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "favorites", :force => true do |t|
      t.integer  "user_id"
      t.string   "location"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "neighborhoods", :force => true do |t|
      t.integer  "district_id"
      t.string   "name"
      t.datetime "created_at",  :null => false
      t.datetime "updated_at",  :null => false
    end

    create_table "postings", :force => true do |t|
      t.integer  "user_id"
      t.date     "date"
      t.time     "starting_time"
      t.time     "ending_time"
      t.datetime "created_at",                :null => false
      t.datetime "updated_at",                :null => false
      t.text     "comments"
      t.boolean  "smoking"
      t.string   "driving"
      t.string   "from_address_neighborhood"
      t.string   "from_address_district"
      t.string   "to_address_neighborhood"
      t.string   "to_address_district"
    end

    create_table "users", :force => true do |t|
      t.string   "name"
      t.string   "email"
      t.datetime "created_at",                                        :null => false
      t.datetime "updated_at",                                        :null => false
      t.string   "password_digest"
      t.string   "remember_token"
      t.boolean  "admin",                          :default => false
      t.string   "preferred_contact_method"
      t.string   "preferred_contact_content"
      t.boolean  "agreed_to_terms_and_conditions"
      t.integer  "trip_rating"
      t.string   "neighborhood"
      t.integer  "total_kms"
      t.string   "summary"
      t.integer  "active"
      t.string   "activation_guid"
    end

    add_index "users", ["email"], :name => "index_users_on_email", :unique => true
    add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  end

  def down
  end
end
