class CartController < BaseController
  
  def show
    @cart_items = current_cart.line_items.includes(:product)
  end

  def destroy
    current_cart.line_items.delete_all
  
    redirect_to cart_path, notice: "Cart cleared successfully!"
  end

end
