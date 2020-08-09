class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  helper_method :get_count
  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        @count=@product.comments.count
        format.js
        format.html { redirect_to @product, notice: 'Comment was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end
  def get_count

  end
  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to request.referer, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:product_id, :body, :user_id)
    end
end
