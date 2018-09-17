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

ActiveRecord::Schema.define(version: 2018_09_14_140143) do

  create_table "line_items", force: :cascade do |t|
    t.integer "quantity", default: 1, null: false
    t.bigint "product_id"
    t.bigint "order_id"
    t.index ["order_id"], name: "index_line_items_on_order_id"
    t.index ["product_id"], name: "index_line_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "name", null: false
    t.float "value", default: 0.0, null: false
    t.bigint "shop_id"
    t.index ["shop_id", "name"], name: "index_orders_on_shop_id_and_name", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.float "value", null: false
    t.bigint "shop_id"
    t.index ["shop_id", "name"], name: "index_products_on_shop_id_and_name", unique: true
  end

  create_table "shops", force: :cascade do |t|
    t.string "name", null: false
  end

end
