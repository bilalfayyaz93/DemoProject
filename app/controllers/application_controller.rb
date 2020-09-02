class ApplicationController < ActionController::Base
  include DeviseWhitelist
  include CurrentCart
  include SetUserCart

  before_action :set_cart

  helper_method :current_cart

  def current_cart
    @current_cart
  end
end
