class CartsController < ApplicationController
  before_action :set_coupon, only: [:update]

  def show
    @line_items = current_cart.line_items.includes(:product)
  end

  def update
    if @coupon && @coupon.expired?
      current_cart.coupon_id = @coupon.id
      current_cart.save
      session[:total_price] = current_cart.discount_price(44)
    end
  end

  def remove_coupon
    current_cart.coupon_id = nil
    if current_cart.save
      session[:total_price] = current_cart.total_price
    end
  end

  private
    def cart_params
      params.require(:cart).permit(:coupon_id, :user_id)
    end

    def set_coupon
      @coupon = coupon.find_by(coupon_code: params[:cart][:code])
    end
end
