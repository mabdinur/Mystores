# README

#### To run this project you will need ruby version '2.X.X' and 'rails', '5.X.X'
#### Follow this tutorial for instructions https://www.tutorialspoint.com/ruby-on-rails/rails-installation.htm


To initalize project:

   In the root folder ..../Mystores
   
	run 'bundle intall' to install all ruby gems
	run 'rails db:drop db:create' to recreate a new local database 
	run 'rails db:migrate' to create the required tables in a local sqllite3 database  
		*****all tables with similar names will be dropped*****
	run 'rails db:seed' to seed the database with data
		seed data can be foud in the ../mystore/db/seeds.rb file


####
#### DO NOT RUN rails db:seed twice!!!! Duplicate Shop, order or product records can not will not be created!!!
####

***NOTE: shop names must be unique***
<br />
***NOTE: order and product names must be unique within each store. You can not create duplicate orders or products (this is case insensitive)*** 
</br>
***ex. A shop named RailsShop can not have two orders named GEMS and gems or products named model and Model.*** 
<br/>

***NOTE: order totals (Order.value) are a running sum, updating the record directly will skew this value. Order totals should only be updated by adding or removing line items*** 
<br />
***NOTE: DO NOT CREATE LINEITEMS using Model.create or delete using Model.delete/Model.destroy. Use LineItems.add and LineItems.remove***
<br />

	run 'rails c' in the ../mystore folder

	To create a shop:
		run 'Shop.create(name: "NameOfShop")'
	To delete a shop:
		run 'Shop.find_by(name: "NameOfShop").destroy'
	To update a shop:
		run 'Shop.find_by(name: "NameOfShop").update(name: "NewName")'
	To read a shop:
		run 'Shop.find_by(name: "NameOfShop")'

	To create an order:
		run 'Order.create(name: "NameofOrder")
	To delete an order:
		run 'Order.find_by(name: "NameOfOrder").destroy'
	TO update an order:
		run 'Order.find_by(name: "NameOfOrder").update(name: "NewName")'
	To read an order:
		run 'Order.find_by(name: "NameOfOrder")
	
	To create a product:
		run 'Product.create(name: "NameofProduct")
	To delete a product:
		run 'Product.find_by(name: "NameofProduct").destroy'
	TO update a product:
		run 'Product.find_by(name: "NameofProduct").update(name: "NewName")'
		run 'Product.find_by(name: "NameofProduct").update(quantity: n)' where n is any integer greater than 0
	To read a product:
		run 'Product.find_by(name: "NameOfProduct")'

	#quantity is an optional parameter with a default value of 1
	#shop_name, product_name, order_name are not case sensitive in the the LineItem.add and LineItem.remove methods
	#LineItem.add and LineItem.remove methods update the corresponding order record (updates the order total)
	To add a line item to an order:
		run 'LineItem.add(shop_name, product_name, order_name, quantity)'
	To remove a line item from an order
		run 'LineItem.remove(shop_name, product_name, order_name, quantity)'
	To check price of a line item
		run 'LineItem.price(shop_name, product_name, order_name)'
