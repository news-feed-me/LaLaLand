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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171104010513) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "subscribes", primary_key: "subscribe_id", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "subscription_id"
    t.boolean  "favourite",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscribes", ["user_id", "subscription_id"], name: "index_subscribes_on_user_id_and_subscription_id", using: :btree

  create_table "subscriptions", primary_key: "subscription_id", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "url"
    t.string   "source_id"
    t.string   "category",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "user_name",       limit: 255, null: false
    t.string   "email",           limit: 255
    t.date     "birth_date"
    t.string   "country",         limit: 255
    t.binary   "profile_picture"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

  create_table "widgets", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "stock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
