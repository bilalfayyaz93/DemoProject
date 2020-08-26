class LineItemsController < ApplicationController
  before_action :set_cart
  before_action :set_line_item, only: [ :update, :destroy]

  def new
    product = Product.find_by(id: params[:prod_id])
    if current_user && current_user.id == product.user_id
      return
    end

    item = @cart.line_items.find_by(product_id: params[:prod_id])

    if item
      item.quantity += 1
      item.quantity = product.quantity if item.quantity > product.quantity

      item.save
    else
      @line_item = @cart.line_items.new
      @line_item.quantity = 1
      @line_item.product_id = product.id
      @line_item.save
    end

    redirect_to request.referer, notice: 'line_item was successfully created.'
  end

  def create
    @line_item = @cart.line_items.build(line_item_params)
    item       = @cart.line_items.find_by(product_id: @line_item.product_id)
    product    = Product.find_by(id: @line_item.product_id)

    if current_user && current_user.id == product.user_id
      @line_item.destroy
      return
    end

    if item
      item.quantity += @line_item.quantity
      item.quantity = product.quantity if item.quantity > product.quantity

      item.save
      @line_item.destroy
    else
      @line_item.quantity  = product.quantity if @line_item.quantity > product.quantity

      @line_item.save
    end

    redirect_to request.referer, notice: 'line_item was successfully created.'
  end

  def destroy
    @line_item.destroy
    redirect_to request.referer, notice: 'line_item was successfully destroyed.'
  end

  def update
    @line_item.update(line_item_params)
    redirect_to request.referer, notice: 'line_item was successfully updated.'
  end

  private
    def set_line_item
      @line_item = @cart.line_items.find(params[:id])
    end

    def set_cart
      @cart = Cart.find(session[:cart_id])
    end

    def line_item_params
      params.require(:line_item).permit(:product_id, :quantity, :user_id)
    end
end
