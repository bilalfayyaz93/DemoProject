class LineItemsController < ApplicationController
  before_action :set_cart
  before_action :set_line_item, only: [ :update, :destroy]

  def create
    @line_item=@cart.line_items.build(line_item_params)
    item=@cart.line_items.where("product_id == #{@line_item.product_id}").first

    if item
      item.quantity += @line_item.quantity
      item.save
      @line_item.destroy
    else
      @line_item.save
    end
    respond_to do |format|
        format.html { redirect_to request.referer, notice: 'line_item was successfully created.' }
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'line_item was successfully destroyed.' }
    end
  end

  def update
    @line_item.update(line_item_params)
    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'line_item was successfully updated.' }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = @cart.line_items.find(params[:id])
    end

    def set_cart
      @cart= Cart.find(session[:cart_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id, :quantity, :user_id)
    end
end
