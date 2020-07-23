# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_23_011945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "altitude_works", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "moas", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "representative"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "moes", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "representative"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ppsps", force: :cascade do |t|
    t.string "address"
    t.date "start"
    t.date "end"
    t.string "nature"
    t.string "workforce"
    t.string "agglomeration"
    t.string "street_impact"
    t.string "river_guidance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.bigint "moa_id", null: false
    t.bigint "moe_id", null: false
    t.bigint "project_information_id", null: false
    t.index ["company_id"], name: "index_ppsps_on_company_id"
    t.index ["moa_id"], name: "index_ppsps_on_moa_id"
    t.index ["moe_id"], name: "index_ppsps_on_moe_id"
    t.index ["project_information_id"], name: "index_ppsps_on_project_information_id"
    t.index ["user_id"], name: "index_ppsps_on_user_id"
  end

  create_table "project_informations", force: :cascade do |t|
    t.string "reference"
    t.string "responsible"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "site_manager_id", null: false
    t.bigint "team_manager_id", null: false
    t.index ["site_manager_id"], name: "index_project_informations_on_site_manager_id"
    t.index ["team_manager_id"], name: "index_project_informations_on_team_manager_id"
  end

  create_table "risks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "selected_altitudes", force: :cascade do |t|
    t.bigint "altitude_work_id"
    t.bigint "ppsp_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["altitude_work_id"], name: "index_selected_altitudes_on_altitude_work_id"
    t.index ["ppsp_id"], name: "index_selected_altitudes_on_ppsp_id"
  end

  create_table "selected_installations", force: :cascade do |t|
    t.bigint "site_installation_id"
    t.bigint "ppsp_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ppsp_id"], name: "index_selected_installations_on_ppsp_id"
    t.index ["site_installation_id"], name: "index_selected_installations_on_site_installation_id"
  end

  create_table "selected_risks", force: :cascade do |t|
    t.bigint "ppsp_id", null: false
    t.bigint "risk_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ppsp_id"], name: "index_selected_risks_on_ppsp_id"
    t.index ["risk_id"], name: "index_selected_risks_on_risk_id"
  end

  create_table "site_installations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "site_managers", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "team_managers", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "ppsps", "companies"
  add_foreign_key "ppsps", "moas"
  add_foreign_key "ppsps", "moes", column: "moe_id"
  add_foreign_key "ppsps", "project_informations"
  add_foreign_key "ppsps", "users"
  add_foreign_key "project_informations", "site_managers"
  add_foreign_key "project_informations", "team_managers"
  add_foreign_key "selected_risks", "ppsps"
  add_foreign_key "selected_risks", "risks"
end
