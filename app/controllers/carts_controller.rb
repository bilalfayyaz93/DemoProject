class CartsController < ApplicationController
  def index
    cart = Cart.find(session[:cart_id])
    @line_items= cart.line_items.all
  end
end
