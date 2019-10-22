module Admin
  class DashboardController < BaseController
    def show
      @user_count = User.count
      @product_count = Product.count
      @promotion_count = Promotion.count
      @coupon_count = Coupon.count
    end
  end
end
