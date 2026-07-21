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

ActiveRecord::Schema[8.1].define(version: 2026_07_21_080332) do
  create_table "ai_reccomendations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "model_used"
    t.text "response"
    t.string "status"
    t.integer "sys_info_id", null: false
    t.datetime "updated_at", null: false
    t.index ["sys_info_id"], name: "index_ai_reccomendations_on_sys_info_id"
  end

  create_table "imported_jsons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "raw_json"
    t.integer "sys_info_id", null: false
    t.datetime "updated_at", null: false
    t.index ["sys_info_id"], name: "index_imported_jsons_on_sys_info_id"
  end

  create_table "sys_infos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "logical_cpu"
    t.string "max_memory"
    t.string "name"
    t.text "notes"
    t.string "rack"
    t.string "slot"
    t.string "system_model"
    t.string "u_position"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ai_reccomendations", "sys_infos"
  add_foreign_key "imported_jsons", "sys_infos"
end
