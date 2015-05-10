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

ActiveRecord::Schema.define(version: 20150510055529) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contractors", force: true do |t|
    t.string   "name"
    t.integer  "acn"
    t.string   "street_adress"
    t.string   "string"
    t.string   "city"
    t.string   "state"
    t.integer  "postcode"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "abn"
  end

  add_index "contractors", ["abn"], name: "index_contractors_on_abn", using: :btree

  create_table "contracts", force: true do |t|
    t.text     "description"
    t.string   "url"
    t.float    "value"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "can_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contractor_id"
  end

  add_index "contracts", ["contractor_id"], name: "index_contracts_on_contractor_id", using: :btree

end
