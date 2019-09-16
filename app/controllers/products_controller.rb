class ProductsController < ApplicationController
  before_action :get_product, only:[:show, :edit, :update, :delete]
  def index
    @products = Product.all
  end
  def new
    @user = current_user
    @product = Product.new
  end
  def create
    puts "---------------\n"*100, params.inspect, product_params.inspect

    Product.create_product(product_params)
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
