class CartsController < ApplicationController
  before_action :set_cart
  def index
    @line_items= @cart.line_items.all
  end




  private

  def set_cart
    @cart=Cart.find(session[:cart_id])
  end
end
