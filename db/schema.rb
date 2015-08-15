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

ActiveRecord::Schema.define(version: 0) do

  create_table "categories", force: true do |t|
    t.string  "name"
    t.integer "replacement_cost"
  end

  create_table "items", force: true do |t|
    t.text     "name"
    t.text     "barcode"
    t.integer  "status",       default: 0
    t.integer  "condition",    default: 0
    t.integer  "borrow_count"
    t.integer  "borrower_id"
    t.integer  "category_id"
    t.integer  "type_id"
    t.datetime "created_on"
    t.integer  "creator_id"
    t.integer  "checkouts",    default: 0
  end

  add_index "items", ["borrower_id"], name: "index_items_on_borrower_id"
  add_index "items", ["category_id"], name: "index_items_on_category_id"
  add_index "items", ["creator_id"], name: "index_items_on_creator_id"
  add_index "items", ["type_id"], name: "index_items_on_type_id"

  create_table "notes", force: true do |t|
    t.text     "text"
    t.integer  "item_id"
    t.integer  "creator_id"
    t.datetime "created_on"
  end

  add_index "notes", ["creator_id"], name: "index_notes_on_creator_id"
  add_index "notes", ["item_id"], name: "index_notes_on_item_id"

  create_table "types", force: true do |t|
    t.string  "name"
    t.integer "borrow_duration"
    t.float   "late_fee"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_on"
    t.boolean  "admin",           default: false
    t.integer  "admin_level"
    t.string   "password_digest"
    t.string   "email"
  end

end
