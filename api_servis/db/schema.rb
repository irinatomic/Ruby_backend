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

ActiveRecord::Schema[7.1].define(version: 6) do
  create_table "Categories", force: :cascade do |t|
    t.string "name", limit: 75, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "FlowerInProducts", force: :cascade do |t|
    t.integer "product_id"
    t.integer "flower_id"
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "Flowers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "OrderItems", force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.integer "quantity", null: false
    t.integer "unit_price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "Orders", force: :cascade do |t|
    t.datetime "scheduled_time", precision: nil, null: false
    t.string "order_status", null: false
    t.string "address", null: false
    t.string "phone", null: false
    t.string "email", null: false
    t.string "full_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_Orders_on_user_id"
  end

  create_table "Products", force: :cascade do |t|
    t.string "name", limit: 75, null: false
    t.string "description", limit: 255, null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id", null: false
    t.index ["category_id"], name: "index_Products_on_category_id"
    t.index ["name"], name: "index_Products_on_name", unique: true
  end

  create_table "Users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password", null: false
    t.boolean "admin", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "FlowerInProducts", "Flowers", column: "flower_id"
  add_foreign_key "FlowerInProducts", "Products", column: "product_id"
  add_foreign_key "OrderItems", "Orders", column: "order_id"
  add_foreign_key "OrderItems", "Products", column: "product_id"
  add_foreign_key "Orders", "Users", column: "user_id"
  add_foreign_key "Products", "Categories", column: "category_id"
end
