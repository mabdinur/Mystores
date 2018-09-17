# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "\nCREATING TEST SHOP"
store = Shop.create(name: "FirstShop")
puts store.inspect

puts "\nCREATING TEST ORDER"
order1 = Order.create(name: "FirstOrder", shop_id: store.id)
puts order1.inspect

puts "\nCREATING TEST PRODUCTS"
prod1 = Product.create(name: "FirstProduct", shop_id: store.id, value: 5)
puts prod1.inspect
prod2 = Product.create(name: "SecondProduct", shop_id: store.id, value: 3)
puts prod2.inspect
prod3 = Product.create(name: "ThirdProduct", shop_id: store.id, value: 2)
puts prod3.inspect

puts "\nCREATING TEST LINE ITEMS"
l1 = LineItem.add("FirstShop", "ThirdProduct", "FirstOrder", 3)
puts "#{l1.inspect} Add 3 ThirdProduct in FirstShop to lineitem"
l2 = LineItem.add("FirstShop", "FirstProduct", "FirstOrder")
puts "#{l2.inspect} Add 1 FirstProduct in FirstShop to lineitem"
l3 = LineItem.add("FirstShop", "SecondProduct", "FirstOrder", 2) 
puts "#{l3.inspect} Add 2 SecondProduct in FirstShop to lineitem"

rm = LineItem.remove("FirstShop", "SecondProduct", "FirstOrder", 1)
puts "Removed 1 SecondProduct from lineitem in FirstShop? #{rm}"

puts "#{Order.find_by(name: "FirstOrder").inspect}, new order total"

puts "\n
	How to use:
	run 'rails c' in the ../mystore folder

	To create a shop:
		run 'Shop.create(name: :NameOfShop)'
	To delete a shop:
		run 'Shop.find_by(name: :NameOfShop).destroy'
	To update a shop:
		run 'Shop.find_by(name: :NameOfShop).update(name: :NewName)'
	To read a shop:
		run 'Shop.find_by(name: :NameOfShop)'

	To create an order:
		run 'Order.create(name: :NameofOrder)
	To delete an order:
		run 'Order.find_by(name: :NameOfOrder).destroy'
	TO update an order:
		run 'Order.find_by(name: :NameOfOrder).update(name: :NewName)'
	To read an order:
		run 'Order.find_by(name: :NameOfOrder)
	
	To create a product:
		run 'Product.create(name: :NameofProduct)
	To delete a product:
		run 'Product.find_by(name: :NameofProduct).destroy'
	TO update a product:
		run 'Product.find_by(name: :NameofProduct).update(name: :NewName)'
	To read a product:
		run 'Product.find_by(name: :NameOfProduct)'

	#quantity is an optional parameter with a default value of 1
	#shop_name, product_name, order_name are not case sensitive in the the LineItem.add and LineItem.remove methods
	#LineItem.add and LineItem.remove methods update the corresponding order record (updates the order total)
	To add a line item to an order:
		run 'LineItem.add(shop_name, product_name, order_name, quantity)'
	To remove a line item from an order
		run 'LineItem.remove(shop_name, product_name, order_name, quantity)'
	To check price of a line item
		run 'LineItem.price(shop_name, product_name, order_name)'"


