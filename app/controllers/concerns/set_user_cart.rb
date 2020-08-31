module SetUserCart
  extend ActiveSupport::Concern

  included do
    after_action :set_user_cart, only: [:create] ,if: :devise_controller?
  end

  def set_user_cart
    return if session[:is_user_cart_set]

    if current_user
      session[:is_user_cart_set] = true
      merge
    end
  end

  def merge
    session_cart = Cart.find(session[:cart_id])
    user_cart = current_user.cart
    if(user_cart)
      session[:cart_id] = user_cart.id
      items = session_cart.line_items.includes(:product)
      items.each do |item|
        line_item_in_user_cart = user_cart.line_items.find_by(product_id: item.product_id)
        if line_item_in_user_cart
          line_item_in_user_cart.quantity += item.quantity
          line_item_in_user_cart.save
        elsif item.product.user != current_user
            new_item = user_cart.line_items.new
            new_item.quantity = item.quantity
            new_item.product_id = item.product_id
            new_item.save
        end
      end
    else
      session_cart.user = current_user
      session_cart.save
    end
  end
end
