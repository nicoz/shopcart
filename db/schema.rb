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

ActiveRecord::Schema.define(version: 20140407192245) do

  create_table "configurations", force: true do |t|
    t.string   "application_name"
    t.string   "application_title"
    t.string   "application_slogan"
    t.string   "application_logo"
    t.string   "application_icon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "generals", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "slogan"
    t.string   "icon"
    t.string   "logo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orden_compras", force: true do |t|
    t.float    "total"
    t.boolean  "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_informations", force: true do |t|
    t.integer  "service_id"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: true
  end

  create_table "services", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",       default: true
    t.string   "service_type"
  end

  create_table "social_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "service_id"
    t.string   "name"
    t.string   "email"
    t.string   "social_id"
    t.string   "social_name"
    t.string   "social_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "static_pages", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "avatar"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.boolean  "active",          default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
