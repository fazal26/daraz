class ProductsController < ApplicationController
  before_action :get_product, only:[:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.create_product(product_params)
    redirect_to user_products_path(current_user)
  end

  def show
    @comments = Comment.where(product_id: @product.id)
    @comment = Comment.new
  end

  def edit
  end

  def update
  end

  def destroy
    @product.delete
    redirect_to user_products_path(current_user)
  end

  private

  def get_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :price, image:[])
  end

end
