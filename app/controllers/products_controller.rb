class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :user_products]
  before_action :set_user_product, only: [:edit, :update, :destroy, :purge_image]
  before_action :set_product, only: [:show]

  PRODUCTS_PER_PAGE = 8

  def index
    @products = Product.search(params[:search])

    @page_count = (@products.count.to_f / PRODUCTS_PER_PAGE).ceil
    @page       = [[params.fetch(:page, 0).to_i, 0].max, @page_count-1].min
    #@products  = @products.offset(@page * PRODUCTS_PER_PAGE).limit(PRODUCTS_PER_PAGE)
    @products   = @products[@page * PRODUCTS_PER_PAGE, PRODUCTS_PER_PAGE]
  end

  def user_products
    @products = current_user.products

    @page_count = (@products.count.to_f / PRODUCTS_PER_PAGE).ceil
    @page       = [[params.fetch(:page, 0).to_i, 0].max, @page_count-1].min
    @products   = @products[@page * PRODUCTS_PER_PAGE, PRODUCTS_PER_PAGE]
  end

  def show
    @comments = @product.comments.includes(:user) if @product
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
      redirect_to request.referer, notice: 'Product was successfully destroyed.'
    else
      redirect_to request.referer, products_url, notice: 'Product was not successfully destroyed.'
    end
  end

  def purge_image
    if @product.photos.count > 1
      photo = @product.photos.find_by(id: params[:img_id])

      if photo
        photo.purge
      end
    end

    redirect_to request.referer
  end

  private
    def set_product
      @product = Product.find_by(id: params[:id])
    end

    def set_user_product
      @product = current_user.products.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :quantity, :price ,photos: [])
    end
end
