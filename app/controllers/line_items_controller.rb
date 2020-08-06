class LineItemsController < ApplicationController
  before_action :set_line_item, only: [  :destroy]

  def create
    @product = Product.find(params[:product_id])
    @cart = Cart.where(user_id: current_user.id).first
    @line_item=@cart.line_items.new
    @line_item.product_id = @product.id

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to responce.referer, notice: 'line_item was successfully created.' }
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'line_item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id, :quantity, :user_id)
    end
end
