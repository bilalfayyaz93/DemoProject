class ProductsController < ApplicationController
  before_action :set_user_product, only: [ :edit, :update, :destroy]
  before_action :set_product, only: [:show]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  def index
    @products = Product.all
    #Rails.logger.info "Check out this info!"
  end

  def show
    @comments= @product.comments.all
  end

  def new
    @product = current_user.products.new
  end

  def edit

  end

  def create
    @product = current_user.products.build(product_params)

    if @product.save
      redirect_to root_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      redirect_to products_url, notice: 'Product was successfully destroyed.'
    else
      redirect_to products_url, notice: 'Product was not successfully destroyed.'
    end
  end

  def delete_image
    @image = ActiveStorage::Attachment.find(params[:img_id])
    @image.purge

    redirect_back(fallback_location: request.referer)
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def set_user_product
      @product = current_user.products.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :quantity, :price ,photos: [])
    end
end
