class OrdersController < BaseController
  before_action :authenticate_user!
  before_action :set_order, only: [:pending_order]
  before_action :set_items, only: [:pending_order]

  def index
    @orders = current_user.orders.completed
  end

  def pending_order
    @order_items = @order.line_items.includes(:product)
  end

  def apply_coupon
    @updated_price = 0
    coupon = coupon_valid?
    
    if coupon.present?
      @updated_price = discounted_price(coupon)
      
      @order.update(coupon: coupon, cost: order_params["grand_total"].to_f, total_cost: @updated_price)
    else
      @cart.update(coupon: nil, cost: order_params["grand_total"].to_f, total_cost: order_params["grand_total"].to_f)
      
    end

    respond_to do |format|
      format.json { render json: @updated_price }
    end
  end

  private
  
  def coupon_valid?
    Coupon.active.find_by(title: order_params["coupon_code"])
  end

  def discounted_price(coupon)
    order_params["grand_total"].to_f - (coupon.discount.to_f / 100) * order_params["grand_total"].to_f
  end

  def set_order
    @order = current_user.orders.pending.present? ? current_user.orders.pending.first : current_user.orders.create(status: :pending)
  end

  def set_items
    byebug
    if @order && @order.line_items.size > 0
      @items = @order.line_items.includes(:product)

      if @cart_items.present?
        @items += @cart_items
      end

    else
      if @cart_items.present?
        @cart_items.each do |item|
          item.update(itemable: @order)
        end
      end
    end

    redirect_to products_url, alert: "No items!" if @items.empty?
  end

  def set_cart_items
    @cart_items = current_user.cart.line_items.includes(:product)
  end

  def order_params
    params.require(:order).permit(:grand_total, :coupon_code)
  end
end
