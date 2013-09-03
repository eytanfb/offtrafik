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

ActiveRecord::Schema.define(:version => 20130211043937038) do

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
    t.string   "from_address"
    t.string   "to_address"
    t.integer  "user_id"
    t.date     "date"
    t.time     "starting_time"
    t.time     "ending_time"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.float    "longitude"
    t.float    "latitude"
    t.boolean  "gmaps"
    t.text     "comments"
    t.boolean  "smoking"
    t.string   "driving"
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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
