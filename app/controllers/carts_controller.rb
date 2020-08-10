class CartsController < ApplicationController
  before_action :set_cart
  def index
    @line_items= @cart.line_items.all
  end


  def update
    coupen=Coupen.find_by(id: @cart.coupen_id)
    if !coupen
      @cart.coupen_id=nil
      @cart.save
      redirect_to request.referer, notice: 'Coupen id does not exist'
      return
    end
    @cart.update(cart_params)
    redirect_to request.referer
  end

  private

  def set_cart
    @cart=Cart.find(session[:cart_id])
  end
  def cart_params
    params.require(:cart).permit(:coupen_id, :user_id)
  end
end
