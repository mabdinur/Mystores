class Order < ApplicationRecord
	belongs_to :shop
	has_many :line_items, :dependent => :destroy
	####All orders are in CAD
end