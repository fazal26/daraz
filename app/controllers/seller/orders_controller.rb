class Seller::OrdersController < SellerController

  def index
    @orders = current_user.orders
  end
end
