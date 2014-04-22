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

ActiveRecord::Schema.define(version: 20140422185317) do

  create_table "configurations", force: true do |t|
    t.string   "application_name"
    t.string   "application_title"
    t.string   "application_slogan"
    t.string   "application_logo"
    t.string   "application_icon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "field_maps", force: true do |t|
    t.integer  "field_type_id"
    t.string   "key"
    t.string   "value"
    t.boolean  "active",        default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "field_maps", ["field_type_id", "key"], name: "index_field_maps_on_field_type_id_and_key"

  create_table "field_posibilities", force: true do |t|
    t.integer  "field_type_id"
    t.string   "text"
    t.boolean  "active",        default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "field_posibilities", ["field_type_id", "text"], name: "index_field_posibilities_on_field_type_id_and_text"

  create_table "field_types", force: true do |t|
    t.string   "name"
    t.boolean  "active",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "field_type"
  end

  add_index "field_types", ["name"], name: "index_field_types_on_name"

  create_table "field_validations", force: true do |t|
    t.string   "name"
    t.text     "parameters"
    t.integer  "field_type_id"
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

  create_table "item_field_validations", force: true do |t|
    t.integer  "item_field_id"
    t.integer  "field_validation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_fields", force: true do |t|
    t.string   "name"
    t.string   "label"
    t.boolean  "searchable",      default: false
    t.boolean  "active",          default: true
    t.integer  "field_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_version_id"
    t.string   "act_as",          default: "value"
    t.integer  "weight",          default: 0
  end

  add_index "item_fields", ["id"], name: "index_item_fields_on_item_id_and_id"
  add_index "item_fields", ["weight"], name: "index_item_fields_on_weight"

  create_table "item_instance_version_values", force: true do |t|
    t.text     "value"
    t.integer  "item_field_id"
    t.integer  "item_instance_version_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "item_instance_versions", force: true do |t|
    t.integer  "item_instance_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_instance_versions", ["item_instance_id", "id"], name: "index_item_instance_versions_on_item_instance_id_and_id"

  create_table "item_instances", force: true do |t|
    t.boolean  "active",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_version_id"
  end

  create_table "item_versions", force: true do |t|
    t.integer  "item_id"
    t.string   "state",      default: "open"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_versions", ["item_id", "state"], name: "index_item_versions_on_item_id_and_state"

  create_table "items", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: true
    t.string   "image"
  end

  add_index "items", ["name"], name: "index_items_on_name"

  create_table "orden_compras", force: true do |t|
    t.float    "total"
    t.boolean  "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_informations", force: true do |t|
    t.integer  "service_id"
    t.string   "key"
    t.text     "value",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                 default: true
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
