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

ActiveRecord::Schema.define(version: 2022_04_17_164828) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "daily_reports", force: :cascade do |t|
    t.bigint "user_id"
    t.string "answered"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "touch_date"
    t.string "touch_location"
    t.bigint "organization_id"
    t.string "eno"
    t.date "need_tracking_till"
    t.index ["organization_id"], name: "index_daily_reports_on_organization_id"
    t.index ["user_id"], name: "index_daily_reports_on_user_id"
  end

  create_table "footprints", force: :cascade do |t|
    t.string "pdf_url"
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "healthy_trackings", force: :cascade do |t|
    t.float "body_temperature"
    t.string "foot_step"
    t.string "health_feels_today"
    t.string "health_feels_weeks"
    t.string "note"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_healthy_trackings_on_user_id"
  end

  create_table "org_summeries", force: :cascade do |t|
    t.integer "need_reports"
    t.integer "reported"
    t.bigint "organization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_org_summeries_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.boolean "is_sales"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.string "name"
    t.string "eno"
    t.string "org"
    t.string "line_id"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "organization_id"
    t.string "real_name"
    t.integer "role"
    t.index ["line_id"], name: "index_users_on_line_id", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
  end

  add_foreign_key "healthy_trackings", "users"
  add_foreign_key "org_summeries", "organizations"
end
