# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140419212834) do

  create_table "comments", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "text"
    t.integer  "rating"
    t.integer  "is_about"
    t.integer  "user_id"
  end

  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

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

  add_index "favorites", ["user_id"], :name => "index_favorites_on_user_id"

  create_table "frequent_days", :force => true do |t|
    t.string   "day"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "frequent_posting_id"
  end

  add_index "frequent_days", ["frequent_posting_id"], :name => "index_frequent_days_on_frequent_posting_id"

  create_table "frequent_postings", :force => true do |t|
    t.date     "last_date"
    t.string   "from_address"
    t.string   "to_address"
    t.boolean  "smoking"
    t.text     "comments"
    t.string   "driving"
    t.time     "starting_time"
    t.time     "ending_time"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "frequent_postings", ["user_id"], :name => "index_frequent_postings_on_user_id"

  create_table "neighborhoods", :force => true do |t|
    t.integer  "district_id"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "neighborhoods", ["district_id"], :name => "index_neighborhoods_on_district_id"

  create_table "posting_responses", :force => true do |t|
    t.integer  "responder_id"
    t.integer  "posting_id"
    t.boolean  "accepted"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.boolean  "poster_agreed"
    t.boolean  "responder_agreed"
  end

  add_index "posting_responses", ["posting_id"], :name => "index_posting_responses_on_posting_id"

  create_table "postings", :force => true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.time     "starting_time"
    t.time     "ending_time"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.text     "comments"
    t.boolean  "smoking"
    t.string   "driving"
    t.string   "from_address"
    t.string   "to_address"
  end

  add_index "postings", ["user_id"], :name => "index_postings_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                          :default => "", :null => false
    t.string   "encrypted_password",             :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                  :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "agreed_to_terms_and_conditions"
    t.integer  "trip_rating"
    t.string   "summary"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "neighborhood"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "unconfirmed_email"
    t.string   "phone"
    t.boolean  "driver"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
