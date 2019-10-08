class Seller::OrdersController < BaseController

  def index
    @orders = current_user.orders
  end
end
