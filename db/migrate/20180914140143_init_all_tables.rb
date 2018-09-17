class InitAllTables < ActiveRecord::Migration[5.2]
  def change
  	create_table "shops", force: :cascade do |t|
    	t.string "name", null: false, unique: true
  	end

  	create_table "products", force: :cascade do |t|
    	t.string "name", null: false
    	t.float  "value", null: false
    	t.bigint "shop_id"
    	t.index ["shop_id", "name"], unique: true
  	end

  	create_table "orders", force: :cascade do |t|
    	t.string "name", null: false
    	t.float  "value", default: 0, null: false
    	t.bigint "shop_id"
    	t.index ["shop_id", "name"], unique: true
  	end

  	create_table "line_items", force: :cascade do |t|
  		t.integer "quantity", null: false, default: 1
    	t.bigint "product_id"
    	t.bigint "order_id"
    	t.index ["product_id"]
    	t.index ["order_id"]
  	end

  	add_foreign_key "orders", "shop"
  	add_foreign_key "products", "shop" 
  	add_foreign_key "line_items", "orders"
  	add_foreign_key "line_items", "orders" 
  end
end
