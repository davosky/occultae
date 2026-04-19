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

ActiveRecord::Schema[8.1].define(version: 2026_04_19_081710) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "features", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "grouping"
    t.string "name"
    t.bigint "node_id", null: false
    t.datetime "updated_at", null: false
    t.index ["node_id"], name: "index_features_on_node_id"
  end

  create_table "groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "groups_nodes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "group_id", null: false
    t.bigint "node_id", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_groups_nodes_on_group_id"
    t.index ["node_id"], name: "index_groups_nodes_on_node_id"
  end

  create_table "groups_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "group_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["group_id"], name: "index_groups_users_on_group_id"
    t.index ["user_id"], name: "index_groups_users_on_user_id"
  end

  create_table "groups_voices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "group_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "voice_id", null: false
    t.index ["group_id"], name: "index_groups_voices_on_group_id"
    t.index ["voice_id"], name: "index_groups_voices_on_voice_id"
  end

  create_table "nodes", force: :cascade do |t|
    t.string "ancestry"
    t.integer "ancestry_depth"
    t.string "application_filters"
    t.datetime "created_at", null: false
    t.boolean "enabled"
    t.boolean "enabled_login"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "nodes_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "node_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["node_id"], name: "index_nodes_users_on_node_id"
    t.index ["user_id"], name: "index_nodes_users_on_user_id"
  end

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
    t.string "password_digest"
    t.string "province"
    t.string "region"
    t.datetime "updated_at", null: false
    t.string "username"
  end

  create_table "users_voices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "voice_id", null: false
    t.index ["user_id"], name: "index_users_voices_on_user_id"
    t.index ["voice_id"], name: "index_users_voices_on_voice_id"
  end

  create_table "voices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "feature_id", null: false
    t.bigint "group_id"
    t.string "grouping"
    t.string "name"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "value_option", default: 0, null: false
    t.integer "value_type", default: 0, null: false
    t.index ["feature_id"], name: "index_voices_on_feature_id"
    t.index ["group_id"], name: "index_voices_on_group_id"
    t.index ["user_id"], name: "index_voices_on_user_id"
  end

  add_foreign_key "features", "nodes"
  add_foreign_key "groups_nodes", "groups"
  add_foreign_key "groups_nodes", "nodes"
  add_foreign_key "groups_users", "groups"
  add_foreign_key "groups_users", "users"
  add_foreign_key "groups_voices", "groups"
  add_foreign_key "groups_voices", "voices"
  add_foreign_key "nodes_users", "nodes"
  add_foreign_key "nodes_users", "users"
  add_foreign_key "users_voices", "users"
  add_foreign_key "users_voices", "voices"
  add_foreign_key "voices", "features"
  add_foreign_key "voices", "groups"
  add_foreign_key "voices", "users"
end
