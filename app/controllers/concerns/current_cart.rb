module CurrentCart
  extend ActiveSupport::Concern

  included do
    before_action :set_cart
  end

  def set_cart
    @current_cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @current_cart = Cart.create
    session[:cart_id] = @current_cart.id
  end
end
