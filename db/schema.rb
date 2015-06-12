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

ActiveRecord::Schema.define(version: 20150612133354) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contractors", force: true do |t|
    t.string   "name"
    t.string   "acn"
    t.string   "street_adress"
    t.string   "string"
    t.string   "city"
    t.string   "state"
    t.integer  "postcode"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "abn"
    t.string   "website"
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
    t.date     "date_scraped"
    t.string   "agency"
    t.text     "provisions_for_additional_services"
    t.string   "method_of_tendering"
    t.text     "provisions_for_changing_value"
    t.text     "provisions_for_renegotiation"
    t.text     "tender_evaluation_criteria"
    t.boolean  "piggyback_clause"
    t.text     "subcontractors"
  end

  add_index "contracts", ["contractor_id"], name: "index_contracts_on_contractor_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
