module CurrentOrder

  def create_order
    order           = current_user.orders.new
    order.coupon_id = current_cart.coupon_id
    line_items      = current_cart.line_items.includes(:product)

    order.save

    line_items.each do |item|
      new_prod = order.sold_products.new
      new_prod.product_id = item.product_id
      new_prod.quantity = item.quantity
      new_prod.price = item.product.price

      if new_prod.save
        prod = Product.find(new_prod.product_id)
        prod.quantity -= new_prod.quantity
        prod.save
      end
    end

    current_cart.line_items.destroy_all

    if current_cart.coupon_id
      current_cart.coupon_id = nil
      current_cart.save
    end
  end
end
