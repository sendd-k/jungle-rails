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

ActiveRecord::Schema.define(version: 2022_07_01_013033) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "conversations", id: :serial, force: :cascade do |t|
    t.text "message", null: false
    t.datetime "created_time"
    t.integer "message_id"
    t.integer "owner_id"
  end

  create_table "favourites", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "listing_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.integer "item_price_cents"
    t.integer "total_price_cents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_line_items_on_order_id"
    t.index ["product_id"], name: "index_line_items_on_product_id"
  end

  create_table "listings", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.text "description", null: false
    t.integer "price", null: false
    t.datetime "created"
    t.boolean "active", default: true, null: false
    t.boolean "condition", default: true, null: false
    t.integer "user_id"
    t.integer "niche_id"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.datetime "created_time"
    t.integer "receiver_id"
    t.integer "sender_id"
    t.integer "listing_id"
  end

  create_table "niches", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "total_cents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "stripe_charge_id"
    t.string "email"
  end

  create_table "photos", id: :serial, force: :cascade do |t|
    t.string "photo_1", limit: 255, null: false
    t.string "photo_2", limit: 255
    t.string "photo_3", limit: 255
    t.string "photo_4", limit: 255
    t.integer "listing_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.integer "price_cents"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_listings", id: :serial, force: :cascade do |t|
    t.integer "listing_id"
  end

  add_foreign_key "conversations", "messages", name: "conversations_message_id_fkey", on_delete: :cascade
  add_foreign_key "favourites", "listings", name: "favourites_listing_id_fkey", on_delete: :cascade
  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "products"
  add_foreign_key "listings", "niches", column: "niche_id", name: "listings_niche_id_fkey", on_delete: :cascade
  add_foreign_key "messages", "listings", name: "messages_listing_id_fkey", on_delete: :cascade
  add_foreign_key "photos", "listings", name: "photos_listing_id_fkey", on_delete: :cascade
  add_foreign_key "products", "categories"
  add_foreign_key "users_listings", "listings", name: "users_listings_listing_id_fkey", on_delete: :cascade
end
