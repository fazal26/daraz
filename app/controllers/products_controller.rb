class ProductsController < ApplicationController
  before_action :set_product, only:[:show, :edit, :update, :destroy]
  around_action :authorize_user, only: [:update, :edit, :destroy]

  def index
    if params[:query].present?
      @products = Product.search(params[:query])
    else
      @products = Product.all
    end
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.create_with_image(current_user, product_params)

    if product.present?
      redirect_to product, notice: "Product was successfully created."
    else
      render :new
    end
  end

  def show
    @comments = @product.comments.reverse
    @comment = Comment.new
  end

  def update
    @product.update!({title: product_params[:title], price: product_params[:price], user_id: current_user.id})
    @product.images.attach(product_params[:image]) if product_params[:image].present?
    
    if @product.save
      redirect_to products_path, notice: "Product successfully updated!"
    else
      redirect_to products_path, alert: "Product not updated!"
    end
  end

  def destroy
    if @product.destroy
      redirect_to products_path, notice: "Product successfully deleted!"
    else
      redirect_to products_path, alert: "Product not deleted!"
    end
  end

  def autocomplete
    render json: Product.search(params[:query], {
      fields: ["title"],
      match: :word_start,
      limit: 5,
      load: false,
      misspellings: {below: 5}
    }).map(&:title)
  end

  private

  def set_product
    @product = Product.includes(:comments).find_by(id: params[:id])
    redirect_to products_path, alert: 'Product does not exist!' if @product.nil?
  end

  def product_params
    params.require(:product).permit(:title, :price, :quantity, :description, image:[])
  end

  def authorize_user
    if @product.present? && @product.user_id == current_user.id
      yield

    else
      redirect_to products_url, alert: "Not Authorized :@"
    
    end
  end

end
