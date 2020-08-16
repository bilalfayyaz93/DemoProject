class LineItemsController < ApplicationController
  before_action :set_cart
  before_action :set_line_item, only: [ :update, :destroy]

  def create
    @line_item = @cart.line_items.build(line_item_params)
    item=@cart.line_items.find_by(product_id: @line_item.product_id)
    #check quantity
    if item
      item.quantity += @line_item.quantity

      item.save
      @line_item.destroy
    else
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
      @cart= Cart.find(session[:cart_id])
    end

    def line_item_params
      params.require(:line_item).permit(:product_id, :quantity, :user_id)
    end
end
