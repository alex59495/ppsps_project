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

ActiveRecord::Schema.define(version: 2021_02_08_161812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "altitude_works", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "anti_poisons", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_destroyed", default: false
    t.index ["company_id"], name: "index_anti_poisons_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "representative"
    t.text "content_secu", default: ""
  end

  create_table "conductors", force: :cascade do |t|
    t.bigint "ppsp_id"
    t.bigint "machine_id", null: false
    t.bigint "worker_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["machine_id"], name: "index_conductors_on_machine_id"
    t.index ["ppsp_id"], name: "index_conductors_on_ppsp_id"
    t.index ["user_id"], name: "index_conductors_on_user_id"
    t.index ["worker_id"], name: "index_conductors_on_worker_id"
  end

  create_table "deminings", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_destroyed", default: false
    t.index ["company_id"], name: "index_deminings_on_company_id"
  end

  create_table "direccts", force: :cascade do |t|
    t.string "address"
    t.string "phone"
    t.string "fax"
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_destroyed", default: false
    t.string "website"
    t.index ["company_id"], name: "index_direccts_on_company_id"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_destroyed", default: false
    t.index ["company_id"], name: "index_hospitals_on_company_id"
  end

  create_table "kit_security_elements", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.string "name"
    t.integer "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_kit_security_elements_on_company_id"
  end

  create_table "machines", force: :cascade do |t|
    t.string "category"
    t.string "caces"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "moas", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "representative"
    t.string "phone"
    t.string "email"
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_destroyed", default: false
    t.index ["company_id"], name: "index_moas_on_company_id"
  end

  create_table "moes", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "representative"
    t.string "phone"
    t.string "email"
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_destroyed", default: false
    t.index ["company_id"], name: "index_moes_on_company_id"
  end

  create_table "pension_insurances", force: :cascade do |t|
    t.string "address"
    t.string "phone"
    t.string "fax"
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_destroyed", default: false
    t.string "website"
    t.index ["company_id"], name: "index_pension_insurances_on_company_id"
  end

  create_table "ppsps", force: :cascade do |t|
    t.string "agglomeration"
    t.string "street_impact"
    t.string "river_guidance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "moa_id", null: false
    t.bigint "moe_id", null: false
    t.bigint "project_information_id", null: false
    t.bigint "direcct_id", null: false
    t.bigint "regional_committee_id", null: false
    t.bigint "pension_insurance_id", null: false
    t.bigint "work_medecine_id", null: false
    t.bigint "demining_id", null: false
    t.bigint "sos_hand_id", null: false
    t.bigint "anti_poison_id", null: false
    t.bigint "hospital_id", null: false
    t.bigint "security_coordinator_id"
    t.text "content_secu", default: ""
    t.bigint "worksite_id", null: false
    t.index ["anti_poison_id"], name: "index_ppsps_on_anti_poison_id"
    t.index ["demining_id"], name: "index_ppsps_on_demining_id"
    t.index ["direcct_id"], name: "index_ppsps_on_direcct_id"
    t.index ["hospital_id"], name: "index_ppsps_on_hospital_id"
    t.index ["moa_id"], name: "index_ppsps_on_moa_id"
    t.index ["moe_id"], name: "index_ppsps_on_moe_id"
    t.index ["pension_insurance_id"], name: "index_ppsps_on_pension_insurance_id"
    t.index ["project_information_id"], name: "index_ppsps_on_project_information_id"
    t.index ["regional_committee_id"], name: "index_ppsps_on_regional_committee_id"
    t.index ["security_coordinator_id"], name: "index_ppsps_on_security_coordinator_id"
    t.index ["sos_hand_id"], name: "index_ppsps_on_sos_hand_id"
    t.index ["user_id"], name: "index_ppsps_on_user_id"
    t.index ["work_medecine_id"], name: "index_ppsps_on_work_medecine_id"
    t.index ["worksite_id"], name: "index_ppsps_on_worksite_id"
  end

  create_table "project_informations", force: :cascade do |t|
    t.string "reference"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "responsible_id"
    t.integer "team_manager_id"
    t.integer "site_manager_id"
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_project_informations_on_company_id"
  end

  create_table "regional_committees", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.string "fax"
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_destroyed", default: false
    t.string "website"
    t.index ["company_id"], name: "index_regional_committees_on_company_id"
  end

  create_table "risks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "security_coordinators", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "representative"
    t.string "phone"
    t.string "email"
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_destroyed", default: false
    t.index ["company_id"], name: "index_security_coordinators_on_company_id"
  end

  create_table "selected_altitudes", force: :cascade do |t|
    t.bigint "altitude_work_id"
    t.bigint "ppsp_id"
    t.string "other"
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

  create_table "selected_lifesavers", force: :cascade do |t|
    t.bigint "ppsp_id", null: false
    t.bigint "worker_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ppsp_id"], name: "index_selected_lifesavers_on_ppsp_id"
    t.index ["worker_id"], name: "index_selected_lifesavers_on_worker_id"
  end

  create_table "selected_risks", force: :cascade do |t|
    t.bigint "ppsp_id", null: false
    t.bigint "risk_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ppsp_id"], name: "index_selected_risks_on_ppsp_id"
    t.index ["risk_id"], name: "index_selected_risks_on_risk_id"
  end

  create_table "selected_subcontractors", force: :cascade do |t|
    t.bigint "ppsp_id", null: false
    t.bigint "subcontractor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ppsp_id"], name: "index_selected_subcontractors_on_ppsp_id"
    t.index ["subcontractor_id"], name: "index_selected_subcontractors_on_subcontractor_id"
  end

  create_table "site_installations", force: :cascade do |t|
    t.string "name"
    t.boolean "mobile"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sos_hands", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_destroyed", default: false
    t.index ["company_id"], name: "index_sos_hands_on_company_id"
  end

  create_table "subcontractors", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "work"
    t.string "responsible_name"
    t.string "responsible_phone"
    t.string "responsible_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "company_id", null: false
    t.boolean "is_destroyed", default: false
    t.index ["company_id"], name: "index_subcontractors_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.bigint "company_id", null: false
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_medecines", force: :cascade do |t|
    t.string "address"
    t.string "phone"
    t.string "fax"
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_destroyed", default: false
    t.index ["company_id"], name: "index_work_medecines_on_company_id"
  end

  create_table "workers", force: :cascade do |t|
    t.boolean "lifesaver"
    t.boolean "conductor"
    t.boolean "is_destroyed", default: false
    t.string "role"
    t.integer "phone"
    t.string "email"
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["company_id"], name: "index_workers_on_company_id"
  end

  create_table "worksites", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.string "nature"
    t.string "workforce"
    t.string "address"
    t.string "timetable_start"
    t.string "timetable_end"
    t.boolean "electrical"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "latitude"
    t.float "longitude"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "anti_poisons", "companies"
  add_foreign_key "conductors", "machines"
  add_foreign_key "conductors", "ppsps"
  add_foreign_key "conductors", "users"
  add_foreign_key "conductors", "workers"
  add_foreign_key "deminings", "companies"
  add_foreign_key "direccts", "companies"
  add_foreign_key "hospitals", "companies"
  add_foreign_key "kit_security_elements", "companies"
  add_foreign_key "moas", "companies"
  add_foreign_key "moes", "companies"
  add_foreign_key "pension_insurances", "companies"
  add_foreign_key "ppsps", "anti_poisons"
  add_foreign_key "ppsps", "deminings"
  add_foreign_key "ppsps", "direccts"
  add_foreign_key "ppsps", "hospitals"
  add_foreign_key "ppsps", "moas"
  add_foreign_key "ppsps", "moes", column: "moe_id"
  add_foreign_key "ppsps", "pension_insurances"
  add_foreign_key "ppsps", "project_informations"
  add_foreign_key "ppsps", "regional_committees"
  add_foreign_key "ppsps", "security_coordinators"
  add_foreign_key "ppsps", "sos_hands"
  add_foreign_key "ppsps", "users"
  add_foreign_key "ppsps", "work_medecines"
  add_foreign_key "ppsps", "worksites"
  add_foreign_key "project_informations", "companies"
  add_foreign_key "regional_committees", "companies"
  add_foreign_key "security_coordinators", "companies"
  add_foreign_key "selected_lifesavers", "ppsps"
  add_foreign_key "selected_lifesavers", "workers"
  add_foreign_key "selected_risks", "ppsps"
  add_foreign_key "selected_risks", "risks"
  add_foreign_key "selected_subcontractors", "ppsps"
  add_foreign_key "selected_subcontractors", "subcontractors"
  add_foreign_key "sos_hands", "companies"
  add_foreign_key "subcontractors", "companies"
  add_foreign_key "users", "companies"
  add_foreign_key "work_medecines", "companies"
  add_foreign_key "workers", "companies"
end
