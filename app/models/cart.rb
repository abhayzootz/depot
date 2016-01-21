class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

def add_product(product_id, quantity)
	current_item = line_items.find_by(product_id: product_id)
	if current_item
		current_item.quantity +=quantity.to_i 
	else
		current_item = line_items.build(product_id: product_id)
		current_item.quantity = quantity.to_i
	end
	current_item
end

	def total_price
		line_items.to_a.sum { |item| item.total_price}
	end
 
  def cart_unlock cart
        cart.line_items.each do |item|
            product = Product.find_by(id: item.product_id)
            product.available_quantity = product.available_quantity + item.quantity
            product.save
        end
    end    

end