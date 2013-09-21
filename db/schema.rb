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

ActiveRecord::Schema.define(:version => 20130921011204) do

  create_table "film_choices", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "film_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "ord"
  end

  add_index "film_choices", ["film_id"], :name => "index_film_choices_on_film_id"
  add_index "film_choices", ["user_id"], :name => "index_film_choices_on_user_id"

  create_table "films", :force => true do |t|
    t.string   "title",      :null => false
    t.integer  "year",       :null => false
    t.string   "director",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "runtime"
    t.string   "genre"
    t.string   "writer"
    t.string   "actors"
    t.text     "plot"
    t.string   "poster"
    t.string   "trailer"
    t.string   "imdbid"
  end

  create_table "followings", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followee_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "followings", ["followee_id"], :name => "index_followings_on_followee_id"
  add_index "followings", ["follower_id"], :name => "index_followings_on_follower_id"

  create_table "houses", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "address"
    t.string   "city"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "houses", ["email"], :name => "index_houses_on_email", :unique => true
  add_index "houses", ["reset_password_token"], :name => "index_houses_on_reset_password_token", :unique => true

  create_table "items", :force => true do |t|
    t.string   "description"
    t.string   "location"
    t.float    "cost"
    t.integer  "mate_id"
    t.boolean  "needed"
    t.boolean  "purchased"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "house_id"
    t.string   "name"
    t.boolean  "createdonmatepage"
    t.boolean  "current"
    t.integer  "month_id"
  end

  create_table "mates", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "house_id"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin"
    t.float    "owes"
    t.float    "account"
    t.boolean  "current_use"
  end

  add_index "mates", ["email"], :name => "index_mates_on_email"
  add_index "mates", ["reset_password_token"], :name => "index_mates_on_reset_password_token", :unique => true

  create_table "mates_months", :force => true do |t|
    t.integer "mate_id"
    t.integer "month_id"
  end

  create_table "months", :force => true do |t|
    t.float    "each_pay"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.float    "total_spent"
    t.integer  "house_id"
  end

  create_table "needs", :force => true do |t|
    t.string   "description"
    t.integer  "house_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "statements", :force => true do |t|
    t.integer  "month_id"
    t.integer  "mate_id"
    t.float    "due_this_month"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.float    "spent_this_month"
  end

  create_table "transactions", :force => true do |t|
    t.string   "payer"
    t.string   "reciever"
    t.integer  "month_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "amount"
    t.integer  "mate_id"
    t.boolean  "paid"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                 :null => false
    t.string   "username",             :null => false
    t.string   "email",                :null => false
    t.string   "password_digest",      :null => false
    t.string   "session_token",        :null => false
    t.string   "profile"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "gravatar_id"
    t.string   "uid"
    t.string   "image"
    t.string   "provider"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "password_reset_token"
  end

  add_index "users", ["session_token"], :name => "index_users_on_session_token", :unique => true

end
