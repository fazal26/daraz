class Seller::CouponsController < SellerController
  before_action :set_coupon, only: [:edit, :update, :destroy]
  
  def index
    @coupons = Coupon.active
  end

  def new
    @coupon = Coupon.new
  end

  def create
    Coupon.create!(coupon_params)
    redirect_to coupons_path
  end

  def edit; end

  def update
    @coupon.update(coupon_params)
  end

  def destroy
    @coupon.destroy
    redirect_to coupons_path
  end

  private
  def coupon_params
    params.require(:coupon).permit(:title, :discount, :expire_at)
  end

  def set_coupon
    @coupon = Coupon.find(params[:id])
  end
end
