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

ActiveRecord::Schema.define(version: 2020_07_07_103949) do

  create_table "books", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "impression_link", null: false
    t.string "api_id", null: false
    t.string "api_path", null: false
    t.string "title", null: false
    t.string "author", null: false
    t.string "thumbnail", default: "/assets/book_img.svg", null: false
    t.date "reading_start_date"
    t.date "reading_end_date"
    t.integer "evaluation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "users_thumbnail"
    t.integer "row_order"
    t.index ["impression_link"], name: "index_books_on_impression_link", unique: true
    t.index ["user_id"], name: "index_books_on_user_id"
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
    t.boolean "tweeted_flg", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "like_count", default: 0
    t.string "tweet_content"
    t.datetime "tweeted_time"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "impression_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["impression_id"], name: "index_likes_on_impression_id"
  end

  create_table "settings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.boolean "publish_impression", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "shelf_type", default: 0, null: false
    t.integer "latest_shelf", default: 0
    t.index ["user_id"], name: "index_settings_on_user_id", unique: true
  end

  create_table "shelf_items", force: :cascade do |t|
    t.integer "shelf_id", null: false
    t.integer "user_id", null: false
    t.integer "book_id", null: false
    t.integer "row_shelf_items_order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_shelf_items_on_book_id"
    t.index ["user_id"], name: "index_shelf_items_on_user_id"
  end

  create_table "shelves", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "shelf_name", null: false
    t.string "shelf_tab_color"
    t.integer "row_shelves_order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_shelves_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "provider"
    t.string "name"
    t.string "nickname"
    t.string "location"
    t.string "image"
    t.string "email", default: ""
    t.string "encrypted_password", default: ""
    t.string "self_introduction"
    t.string "oauth_token"
    t.string "oauth_token_secret"
    t.string "twitter_link"
    t.boolean "admin_flg", default: false, null: false
    t.integer "shelf_type", default: 1, null: false
    t.integer "user_type", default: 1, null: false
    t.boolean "del_flg", default: false, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
