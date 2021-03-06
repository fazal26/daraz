module Seller
  class ProductsController < BaseController
    before_action :set_product, only:[:show, :edit, :update, :destroy]

    def index
      @products = params[:query].present? ? current_user.products.search(params[:query]) : current_user.products
    end

    def new
      @product = Product.new
    end

    def create
      current_user.products.create(product_params)
      redirect_to seller_products_path
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
      params.require(:product).permit(:title, :price, :quantity, :description, images:[])
    end

  end
end