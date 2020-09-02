class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show ]

  include CreateOrder

  def index
    @orders = current_user.orders
  end

  def show
    @order_items = @order.sold_products.includes(:product)
  end

  def new
    create_order
    redirect_to root_path
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:user_id, :coupen_id, :checkout_date)
    end

end
