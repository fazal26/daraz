class ProductsController < ApplicationController
  before_action :set_product, only:[:show, :edit, :update, :destroy]
  
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.create_with_image(product_params)
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

  def search
    render json: Product.search(params[:query], {
      fields: ["title^5"],
      limit: 10,
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
