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

ActiveRecord::Schema.define(version: 2020_02_16_045349) do

  create_table "books", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "impression_link", null: false
    t.string "api_path", null: false
    t.string "title", null: false
    t.string "thumbnail", default: "/assets/images/book_img.svg", null: false
    t.date "reading_start_date"
    t.date "reading_end_date"
    t.integer "evaluation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "contact_type", null: false
    t.string "contact_title", null: false
    t.string "inquiry", null: false
    t.string "response"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "impressions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "book_id", null: false
    t.string "impression"
    t.string "impression_img"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "settings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.boolean "publish_impression", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: ""
    t.string "account_name", default: ""
    t.string "twitter_account"
    t.string "self_introduction"
    t.string "user_icon"
    t.boolean "admin_flg", default: false, null: false
    t.integer "shelf_type", default: 1, null: false
    t.integer "user_type", default: 1, null: false
    t.boolean "del_flg", default: false, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "current_sign_in_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
