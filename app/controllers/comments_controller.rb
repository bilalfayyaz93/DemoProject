class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      @count = @product.comments.count
    else
      redirect_to request.referer
    end
  end

  def destroy
    @comment.destroy
  end

  private
    def set_comment
      @comment = current_user.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:product_id, :body, :user_id)
    end
end
