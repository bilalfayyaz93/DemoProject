class CartsController < ApplicationController
  before_action :set_cart
  before_action :set_coupen, only: [:update]
  def show
    @line_items = @cart.line_items
  end

  def update
    if @coupen.blank?
      redirect_to request.referer, notice: 'Coupen code does not exist'
    elsif @coupen.expirey < Date.today
      redirect_to request.referer, notice: 'Coupen is expired'
    else
      @cart.coupen_id = @coupen.id
      @cart.save

      redirect_to request.referer
    end
  end

  def remove_coupen
    @cart.coupen_id = nil
    if @cart.save
      redirect_to request.referer, notice: 'coupen removed successfully'
    else
      redirect_to request.referer, notice: 'coupen removed failed'
    end
  end

  private
    def set_cart
      @cart = Cart.find(session[:cart_id])
    end

    def cart_params
      params.require(:cart).permit(:coupen_id, :user_id)
    end

    def set_coupen
      @coupen = Coupen.find_by(coupen_code: params[:cart][:code])
    end
end
