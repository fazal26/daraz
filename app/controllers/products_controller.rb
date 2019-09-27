class ProductsController < ApplicationController
  before_action :set_product, only:[:show, :edit, :update, :destroy]
  
  def index
    search = params[:query].present? ? params[:query] : nil
    if search
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
    redirect_to products_path
  end

  def show
    @comments = Product.find(params[:id]).comments.reverse
    @comment = Comment.new
  end

  def update
    @product.update!({title: product_params[:title], price: product_params[:price], user_id: current_user.id})
    @product.images.attach(product_params[:image])
    @product.save
    redirect_to products_path
  end

  def destroy
    @product.destroy!
    redirect_to products_path
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
    @product = Product.includes(:comments).find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :price, image:[])
  end

end
