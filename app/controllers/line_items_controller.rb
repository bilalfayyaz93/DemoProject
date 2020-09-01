class LineItemsController < ApplicationController
  before_action :set_line_item, only: [ :update, :destroy]

  def create
    product = Product.find_by(id: params[:line_item][:product_id])

    if current_user && current_user.id == product.user_id
      return
    end

    item = current_cart.line_items.find_by(product_id: params[:line_item][:product_id])

    if item
      item.quantity += params[:line_item][:quantity].to_i
      item.quantity = product.quantity if item.quantity > product.quantity

      item.save
    else
      @line_item = current_cart.line_items.build(line_item_params)
      @line_item.quantity  = product.quantity if @line_item.quantity > product.quantity

      @line_item.save
    end

    redirect_to request.referer, notice: 'line_item was successfully created.'
  end

  def destroy
    if @line_item.destroy
      redirect_to request.referer, notice: 'line_item was successfully destroyed.'
    else
      redirect_to request.referer, notice: 'line_item was not successfully destroyed.'
    end
  end

  def update
    @line_item.update(line_item_params)
    redirect_to request.referer, notice: 'line_item was successfully updated.'
  end

  private
    def set_line_item
      @line_item = current_cart.line_items.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:product_id, :quantity, :user_id)
    end
end
