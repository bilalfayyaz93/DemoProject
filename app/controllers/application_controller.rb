class ApplicationController < ActionController::Base
  include DeviseWhitelist
  include CurrentCart
  include SetUserCart

  helper_method :current_cart

  def current_cart
    @current_cart
  end
end
