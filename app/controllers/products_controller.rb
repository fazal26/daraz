class ProductsController < BaseController
  before_action :set_product, only:[:show]

  def index
    @titles = Product.pluck(:title)
    @promotions = Promotion.active
    @new_arrivals = Product.available.latest.limit(5)
    current_cart.user = current_user if current_user.present?

    if params[:query].present?
      @products = Product.search(params[:query])
    else
      @products = Product.available.page params[:page]
    end
    respond_to do |format|
      format.html { @products }
      format.json { render json: {titles:  @titles} }
    end
  end

  def show
    @similar_products = Product.order("RANDOM()").limit(5)
    @comments = @product.comments.reverse
    @comment = Comment.new
  end

  def autocomplete
    render json: Product.search(params[:query], {
      fields: ["title"],
      match: :word_start,
      limit: 5,
      load: false,
      misspellings: {below: 3}
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
end
