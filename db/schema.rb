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

ActiveRecord::Schema.define(version: 20140826234925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feedbacks", force: true do |t|
    t.integer  "rate"
    t.text     "suggestion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_states", force: true do |t|
    t.integer  "order_id",   null: false
    t.integer  "user_id"
    t.integer  "staff_id"
    t.string   "action",     null: false
    t.string   "state",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id",     null: false
    t.integer  "product_id",  null: false
    t.float    "price",       null: false
    t.integer  "feedback_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_tags", force: true do |t|
    t.integer  "product_id", null: false
    t.integer  "tag_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "code"
    t.string   "name",           null: false
    t.integer  "provider_id"
    t.text     "description"
    t.text     "specification"
    t.string   "image"
    t.float    "original_price"
    t.float    "price",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "providers", force: true do |t|
    t.string   "code"
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffs", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "staffs", ["reset_password_token"], name: "index_staffs_on_reset_password_token", unique: true, using: :btree
  add_index "staffs", ["unlock_token"], name: "index_staffs_on_unlock_token", unique: true, using: :btree
  add_index "staffs", ["username"], name: "index_staffs_on_username", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                     default: "", null: false
    t.string   "encrypted_password",        default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "uid",                                    null: false
    t.string   "name"
    t.string   "fbid"
    t.string   "student_id"
    t.string   "gender"
    t.boolean  "mobile_verified"
    t.string   "identity"
    t.string   "admission_department_code"
    t.string   "department_code"
    t.string   "admission_department"
    t.string   "department"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
