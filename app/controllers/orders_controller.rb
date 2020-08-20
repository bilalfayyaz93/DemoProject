class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :destroy]
  before_action :set_attr, only: [:new]

  def index
    @orders = current_user.orders
  end

  def show
    @order_items = @order.sold_products
  end

  def new
    @line_items.each do |item|
      @order.sold_products.create(product_id: item.product_id, quantity: item.quantity)
      update_product(item.product_id, item.quantity)
    end

    @cart.line_items.destroy_all

    if(@cart.coupen_id)
      @cart.coupen_id = nil
      @cart.save
    end

    redirect_to root_path
  end

  def destroy
    if @order.destroy
      redirect_to orders_url, notice: 'Order was successfully destroyed.'
    else
      redirect_to orders_url, notice: 'Order was not successfully destroyed.'
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:user_id, :coupen_id, :checkout_date)
    end

    def set_attr
      @order           = current_user.orders.new
      @cart            = Cart.find(session[:cart_id])
      @order.coupen_id = @cart.coupen_id
      @line_items      = @cart.line_items.all

      @order.save
    end

    def update_product(prod_id, quantity)
      prod = Product.find(prod_id)
      prod.quantity -= quantity
      prod.save
    end
end
