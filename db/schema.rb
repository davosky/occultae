# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_03_16_110739) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "supervisors", force: :cascade do |t|
    t.date "birth_date"
    t.string "birth_place"
    t.boolean "boss"
    t.string "category"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "failed_attempts", default: 0, null: false
    t.string "first_name"
    t.string "fiscal_code"
    t.string "gender"
    t.string "institute"
    t.string "last_name"
    t.datetime "locked_at"
    t.boolean "manager"
    t.string "office"
    t.string "province"
    t.string "region"
    t.boolean "regular"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "unlock_token"
    t.datetime "updated_at", null: false
    t.string "username", default: "", null: false
    t.index ["email"], name: "index_supervisors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_supervisors_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_supervisors_on_unlock_token", unique: true
    t.index ["username"], name: "index_supervisors_on_username", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.date "birth_date"
    t.string "birth_place"
    t.string "category"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name"
    t.string "fiscal_code"
    t.string "gender"
    t.string "institute"
    t.string "last_name"
    t.string "office"
    t.string "password"
    t.string "province"
    t.string "region"
    t.datetime "updated_at", null: false
    t.string "username"
  end
end
