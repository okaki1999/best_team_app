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

ActiveRecord::Schema[7.0].define(version: 2024_02_24_153820) do
  create_table "bsk_enrollments", force: :cascade do |t|
    t.integer "bsk_member_id"
    t.integer "bsk_match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bsk_match_id"], name: "index_bsk_enrollments_on_bsk_match_id"
    t.index ["bsk_member_id"], name: "index_bsk_enrollments_on_bsk_member_id"
  end

  create_table "bsk_matches", force: :cascade do |t|
    t.integer "bsk_member_id"
    t.integer "coat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bsk_member_id"], name: "index_bsk_matches_on_bsk_member_id"
  end

  create_table "bsk_members", force: :cascade do |t|
    t.string "name"
    t.integer "scoring_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bsk_match_id"
    t.integer "total_match"
    t.integer "point_per_game"
    t.index ["bsk_match_id"], name: "index_bsk_members_on_bsk_match_id"
  end

  create_table "bsk_participations", force: :cascade do |t|
    t.integer "bsk_member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer "member_id"
    t.integer "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_enrollments_on_match_id"
    t.index ["member_id"], name: "index_enrollments_on_member_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "member_id"
    t.integer "coat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["member_id"], name: "index_matches_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "match_id"
    t.index ["match_id"], name: "index_members_on_match_id"
  end

  create_table "participations", force: :cascade do |t|
    t.integer "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bsk_member_id"
    t.string "participant_type"
    t.integer "participant_id"
    t.index ["participant_type", "participant_id"], name: "index_participations_on_participant"
  end

  add_foreign_key "bsk_enrollments", "bsk_matches"
  add_foreign_key "bsk_enrollments", "bsk_members"
  add_foreign_key "bsk_matches", "bsk_members"
  add_foreign_key "bsk_members", "bsk_matches"
end
