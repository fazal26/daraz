class ProductsController < ApplicationController
  before_action :get_product, only:[:show, :edit, :update, :delete]
  def index
    @products = Product.where(user_id: current_user.id)
  end

  def new
    @user = current_user
    @product = Product.new
  end

  def create
    product = Product.create_product(product_params)
    redirect_to user_products_path(current_user)
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def get_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :price, image:[])
  end

end
