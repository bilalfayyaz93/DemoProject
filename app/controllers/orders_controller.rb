class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :destroy]
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @sold_items=@order.sold_items.all
  end

  # GET /orders/new
  def new
    @order = current_user.orders.new
    @cart=Cart.find(session[:cart_id])
    @order.coupen_id=@cart.coupen_id
    @line_items=@cart.line_items.all
    @order.save
    @line_items.each do |item|
      @order.sold_products.create(product_id: item.product_id, quantity: item.quantity)
      update_product(item.product_id, item.quantity)
    end
    @cart.line_items.destroy_all
    if(@cart.coupen_id)
      Coupen.find(@cart.coupen_id).destroy
      @cart.coupen_id=nil
      @cart.save
    end
    redirect_to root_path
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    respond_to do |format|
      format.html redirect_to orders_url, notice: 'Order was successfully destroyed.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:user_id, :coupen_id, :checkout_date)
    end

    def update_product(prod_id, quantity)
      prod=Product.find(prod_id)
      prod.quantity -= quantity
      if prod.quantity.zero?
        prod.destroy
      else
        prod.save
      end
    end
end
