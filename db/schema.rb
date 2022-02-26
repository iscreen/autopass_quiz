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

ActiveRecord::Schema[7.0].define(version: 2022_02_26_225804) do
  create_table "order_items", force: :cascade do |t|
    t.integer "order_id"
    t.bigint "itemable_id"
    t.string "itemable_type"
    t.integer "quantity", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id", "itemable_id", "itemable_type"], name: "index_order_items_on_order_id_and_itemable_id_and_itemable_type", unique: true
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.integer "state", default: 0
    t.decimal "amount", precision: 14, scale: 4, default: "0.0"
    t.decimal "discount", precision: 10, scale: 4, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "state"], name: "index_orders_on_user_id_and_state"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 10, scale: 4, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_products_on_name", unique: true
  end

  create_table "promotions", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "product_id"
    t.decimal "amount", precision: 12, scale: 4, default: "0.0"
    t.integer "discount_percentage", default: 0
    t.decimal "discount_amount", precision: 6, scale: 4, default: "0.0"
    t.integer "exceed_quantity", default: 0
    t.integer "taken_limitation", default: 0
    t.decimal "discount_amount_limitation", precision: 12, scale: 4, default: "0.0"
    t.decimal "month_discount_amount_limitation", precision: 12, scale: 4, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_promotions_on_product_id"
    t.index ["type", "start_date", "end_date"], name: "index_promotions_on_type_and_start_date_and_end_date"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

end
