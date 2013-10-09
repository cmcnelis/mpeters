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

ActiveRecord::Schema.define(version: 20131009191829) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agent_sessions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agents", force: true do |t|
    t.string   "email"
    t.string   "company"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "last_request_at"
  end

  create_table "drivers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paypal_transactions", force: true do |t|
    t.integer  "amount"
    t.string   "pp_id"
    t.boolean  "approved"
    t.string   "address"
    t.string   "city"
    t.string   "zip_code"
    t.string   "card_number"
    t.string   "card_type"
    t.string   "csc"
    t.string   "exp"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "state"
    t.integer  "policy_id"
  end

  create_table "policies", force: true do |t|
    t.string   "number"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.integer  "agent_id"
  end

  create_table "vehicles", force: true do |t|
    t.string   "vin"
    t.date     "start_date"
    t.date     "expr_date"
    t.string   "make"
    t.string   "model"
    t.string   "color"
    t.integer  "deductible"
    t.integer  "policy_id"
    t.integer  "previous_deductible"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "covered",             default: false
    t.string   "drivers"
    t.integer  "year"
  end

end
