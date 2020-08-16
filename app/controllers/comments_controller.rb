class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        @count = @product.comments.count

        format.js
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.js
    end
  end

  private
    def set_comment
      @comment = current_user.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:product_id, :body, :user_id)
    end
end
