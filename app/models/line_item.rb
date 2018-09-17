class LineItem < ApplicationRecord
	belongs_to :order
	belongs_to :product

	###The method creates or increments the quantity of a lineitem then updates the corresponding order total
	###This method also ensures each product and order specified belong to the same shop
	def self.add(shop_name, product_name, order_name, quantity = 1)	
		shop = LineItem.find_shop shop_name
		product = LineItem.find_product product_name
		order = LineItem.find_order order_name
		if product.shop_id != order.shop_id
			raise "Product #{product_name} and Order #{order_name} are associated with different shops. Line Items could not be added!!"
		else
			line_item = LineItem.add_to_line_item product.id, order.id, quantity
			order_total = order.value + quantity*product.value
			order.update(value: order_total)
			return line_item
		end
	end

	###The method deletes or decrements the quantity of a lineitem then updates the corresponding order total
	###This method also ensures each product and order specified belong to the same shop
	def self.remove(shop_name, product_name, order_name, quantity = 1)	
		shop = LineItem.find_shop shop_name
		product = LineItem.find_product product_name
		order = LineItem.find_order order_name
		if product.shop_id != order.shop_id
			raise "Product #{product_name} and Order #{order_name} are associated with different shops. Line Items could not be added!!"
		else
			LineItem.remove_line_item product.id, order.id, quantity
			order_total = order.value - quantity*product.value
			order.update(value: order_total)
		end
	end

	def self.price(shop_name, product_name, order_name)
		shop = LineItem.find_shop shop_name
		product = LineItem.find_product product_name
		order = LineItem.find_order order_name
		li = LineItem.find_by(product_id: product.id, order_id: order.id)
		if product.shop_id != order.shop_id
			raise "Product #{product_name} and Order #{order_name} are associated with different shops. Line Items could not be added!!"
		elsif li.nil?
			raise "Product #{product_name} can not be found in Order #{order_name}. Please add line item using LineItem.add(shop_name, product_name, order_name, quantity)"
		else
			return "Name: #{product_name.titleize}  Price: $#{li.quantity*product.value}   Quantity: #{li.quantity}"
		end
	end

	private
	def self.find_shop shop_name
		shop = Shop.where("lower(name) = ?", shop_name.downcase).first
		if shop.nil?
			raise "PLEASE ENTER A VALID SHOP NAME. Shop with the name #{shop_name} does not exist"
		else
			return shop
		end
	end

	def self.find_product product_name
		product = Product.where("lower(name) = ?", product_name.downcase).first
		if product.nil?
			raise "PLEASE ENTER A VALID PRODUCT NAME. Product with the name #{product_name} does not exist"
		else
			return product
		end
	end

	def self.find_order order_name
		order = Order.where("lower(name) = ?", order_name.downcase).first
		if order.nil?
			raise "PLEASE ENTER A VALID ORDER NAME. Order with the name #{order_name} does not exist"
		else
			return order
		end
	end

	###Create line item if it does not exist
	###Increment quanity of line item if exactly one exists
	###If duplicate products exist delete all duplicates and create one line item with the correct quantity
	def self.add_to_line_item product_id, order_id, quantity
		line_items = LineItem.where(product_id: product_id, order_id: order_id)
		if line_items.count == 0
			return LineItem.create(product_id: product_id, order_id: order_id, quantity: quantity)
		elsif line_items.count == 1
			total_quanity = line_items.first.quantity + quantity
			line_items.first.update(quantity: total_quanity)
			return line_items.first
		else   
			normalized_line_item = LineItem.combine_duplicates line_items, product_id, order_id
			return normalized_line_item
		end
	end

	###raise error if line item does not exist
	###Decrement quanity of line item by specificed quantity if exactly one exists
	###If duplicate line items exist delete all duplicates and create one line item with the correct quantity then decrement the quantity 
	def self.remove_line_item product_id, order_id, quantity
		line_items = LineItem.where(product_id: product_id, order_id: order_id)
		total_quanity = 0
		####if duplicate items exist delete all duplicates are create one line item with the correct quantity
		if line_items.count == 0
			raise "Item was not found in the order!"
		elsif line_items.count == 1
			item_to_be_removed = line_items.first
		else
			item_to_be_removed = LineItem.combine_duplicates line_items, product_id, order_id
		end

		if item_to_be_removed.quantity < quantity
			raise "#{quantity} items can not be removed, only #{item_to_be_removed.quantity} items were found"
		elsif item_to_be_removed.quantity == quantity
			return item_to_be_removed.destroy
		else
			new_quanity = item_to_be_removed.quantity - quantity
			return item_to_be_removed.update(quantity: new_quanity)
		end
	end

	#####WE SHOULD NEVER NEED TO DELETE DUPLICATES, IF SOME someone does some foolishness and creates lineitems with the create method 
	#####instead of add this will take care of it
	#delete duplicate lineitems and create one new line item with the correct quantity
	def self.combine_duplicates line_items, product_id, order_id
		total_quanity = 0
		line_items.each { |li| total_quanity += li.quantity }
		line_items.destroy_all
		LineItem.create(product_id: product_id, order_id: order_id, quantity: total_quanity)
	end
end