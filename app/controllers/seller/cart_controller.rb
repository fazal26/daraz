class Seller::CartController < SellerController
  before_action :set_cart
  
  def show
    @cart_items = @cart.line_items.includes(:product)
  end

  def destroy
    @cart.line_items.delete_all
  end

  def apply_coupon
    coupon = coupon_valid?

    if coupon.present?
      @updated_price = cart_params["grand_total"].to_f - (coupon.discount.to_f / 100) * cart_params["grand_total"].to_f
    else
      #
    end

    respond_to do |format|
    format.json { render json: @updated_price }
    end
    
  end

  private

  def set_cart
    @cart = current_user.cart
  end

  def cart_params
    params.require(:cart).permit(:grand_total, :coupon_code)
  end

  def coupon_valid?
    Coupon.active.find_by(title: cart_params["coupon_code"])
  end
end

#TODO restrict comment action
#TODO fix comment image
#TODO logged out cart
#TODO ahmed shafiq - namespace for adminpanel and coupon management
