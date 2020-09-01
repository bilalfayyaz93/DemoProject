class CartsController < ApplicationController
  before_action :set_coupen, only: [:update]

  def show
    @line_items = current_cart.line_items.includes(:product)
  end

  def update
    if @coupen.blank?
      redirect_to request.referer, notice: 'Coupen code does not exist'
    elsif @coupen.expirey < Date.today
      redirect_to request.referer, notice: 'Coupen is expired'
    else
      current_cart.coupen_id = @coupen.id
      current_cart.save

      redirect_to request.referer, notice: 'Coupen added successfully'
    end
  end

  def remove_coupen
    current_cart.coupen_id = nil
    if current_cart.save
      redirect_to request.referer, notice: 'coupen removed successfully'
    else
      redirect_to request.referer, notice: 'coupen removed failed'
    end
  end

  private
    def cart_params
      params.require(:cart).permit(:coupen_id, :user_id)
    end

    def set_coupen
      @coupen = Coupen.find_by(coupen_code: params[:cart][:code])
    end
end
