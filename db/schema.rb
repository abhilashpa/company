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

ActiveRecord::Schema.define(version: 20170108131540) do

  create_table "cities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "state_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cities_on_name", unique: true, using: :btree
    t.index ["state_id"], name: "index_cities_on_state_id", using: :btree
  end

  create_table "company_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",            null: false
    t.integer  "no_of_employees", null: false
    t.bigint   "annual_revenue",  null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "company_details_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "company_detail_id"
    t.integer "user_id"
    t.index ["company_detail_id"], name: "index_company_details_users_on_company_detail_id", using: :btree
    t.index ["user_id"], name: "index_company_details_users_on_user_id", using: :btree
  end

  create_table "contact_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "company_detail_id"
    t.string   "email1"
    t.string   "email2"
    t.integer  "landline"
    t.integer  "hr_extension"
    t.bigint   "mobile_phone"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["company_detail_id"], name: "index_contact_details_on_company_detail_id", using: :btree
  end

  create_table "headquater_addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "company_detail_id"
    t.integer  "pincode_id"
    t.string   "address1",          limit: 1000, null: false
    t.string   "address2",          limit: 1000
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["company_detail_id"], name: "index_headquater_addresses_on_company_detail_id", using: :btree
    t.index ["pincode_id"], name: "index_headquater_addresses_on_pincode_id", using: :btree
  end

  create_table "pincodes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "pincode"
    t.integer  "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_pincodes_on_city_id", using: :btree
  end

  create_table "states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "firstname"
    t.string   "lastname"
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "cities", "states"
  add_foreign_key "company_details_users", "company_details"
  add_foreign_key "company_details_users", "users"
  add_foreign_key "contact_details", "company_details"
  add_foreign_key "headquater_addresses", "company_details"
  add_foreign_key "headquater_addresses", "pincodes"
  add_foreign_key "pincodes", "cities"
end
