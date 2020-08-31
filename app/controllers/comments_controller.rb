class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:destroy]
  before_action :set_product, only: [:create]

  def create
    if @product.nil?
      return
    end

    @comment = @product.comments.build(comment_params)

    @comment.user = current_user

    if @comment.save
      @count = @product.comments.count
    end
  end

  def destroy
    unless @comment.nil?
      @comment.destroy
    end
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
