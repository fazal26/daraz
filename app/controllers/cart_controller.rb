class CartController < BaseController
  before_action :set_cart
  
  def show
    @cart_items = @cart.line_items.includes(:product)
  end

  def destroy
    @cart.line_items.delete_all
    redirect_to cart_path, notice: "Cart cleared successfully!"
  end

  private

  def set_cart
    @cart = current_cart
  end

end
