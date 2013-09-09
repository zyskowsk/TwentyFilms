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

ActiveRecord::Schema.define(:version => 20130909165838) do

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
    t.string   "plot"
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

  create_table "users", :force => true do |t|
    t.string   "name",            :null => false
    t.string   "username",        :null => false
    t.string   "email",           :null => false
    t.string   "password_digest", :null => false
    t.string   "session_token",   :null => false
    t.string   "profile"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "gravatar_id"
  end

  add_index "users", ["session_token"], :name => "index_users_on_session_token", :unique => true

end
