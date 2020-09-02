class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:destroy]
  before_action :set_product, only: [:create]

  def create
    return if @product.nil?

    @comment = @product.comments.build(comment_params)
    @comment.user = current_user
    @count = @product.comments.count if @comment.save
  end

  def destroy
    @comment.destroy unless @comment.nil?
  end

  private
    def set_comment
      @comment = current_user.comments.find_by(id: params[:id])
    end

    def comment_params
      params.require(:comment).permit(:product_id, :body, :user_id)
    end

    def set_product
      @product = Product.find_by(id: params[:product_id])
    end
end
