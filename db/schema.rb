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

ActiveRecord::Schema.define(version: 20190223190313) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forecast_days", force: :cascade do |t|
    t.string "icon"
    t.string "summary"
    t.datetime "time"
    t.decimal "high"
    t.decimal "low"
    t.decimal "precip_probability"
    t.string "precip_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forecast_hours", force: :cascade do |t|
    t.string "icon"
    t.string "summary"
    t.datetime "time"
    t.decimal "tempurature"
    t.decimal "feels_like"
    t.decimal "humidity"
    t.decimal "visibility"
    t.integer "uv_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forecasts", force: :cascade do |t|
    t.string "day_summary"
    t.string "week_summary"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_forecasts_on_city_id"
  end

  add_foreign_key "forecasts", "cities"
end
