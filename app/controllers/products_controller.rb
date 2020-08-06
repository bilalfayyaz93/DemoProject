class ProductsController < ApplicationController
  before_action :set_product, only: [ :edit, :update, :destroy]
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @comments= @product.comments.all
  end

  # GET /products/new
  def new
    @product = current_user.products.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = current_user.products.build(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_to_cart
    cart=Cart.find(session[:cart_id])
    if current_user
      product=Product.where("user_id != #{current_user.id} and id == #{params[:id]}").first
    else
      product=Product.where("id == #{params[:id]}").first
    end
    if product
     line_item=cart.line_items.where("product_id == #{params[:id]}").first
     if line_item
       line_item.quantity += 1
     else
       line_item = cart.line_items.new
       line_item.product_id=product.id
       line_item.quantity=1
     end
     line_item.save
    end
    redirect_back(fallback_location: request.referer)
  end

  def delete_from_cart
    cart=Cart.find(session[:cart_id])
    line_item=cart.line_items.where("product_id = #{params[:id]}").first
    quantity=params[:quantity].to_i
    if line_item.quantity > quantity
      line_item.quantity -=quantity
      line_item.save
    else
      line_item.delete
    end
    redirect_back(fallback_location: request.referer)
  end
  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_image
    @image = ActiveStorage::Attachment.find(params[:img_id])
    @image.purge
    redirect_back(fallback_location: request.referer)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = current_user.products.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit( :title, :description, :quantity, :price ,photos: [])
    end
end
