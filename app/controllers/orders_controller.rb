class OrdersController < BaseController
  before_action :authenticate_user!
  before_action :set_order, except: [:index]
  before_action :set_cart_items, except: [:index]
  before_action :set_order_items, except: [:index]
  before_action :manage_order_items, except: [:index], if: -> { @cart_items.present? }  
  before_action :set_order_price, only: [:pending_order]

  def index
    @orders = current_user.orders.completed
  end

  def pending_order
    @order
  end

  def apply_coupon
    coupon = coupon_valid?
    
    if coupon.present? 
      @total_bill = total_bill(@order_items)
      @grand_total = discounted_price(coupon, @total_bill)
      update_order(@total_bill, @grand_total, coupon)
    end

    respond_to do |format|
      format.json { render json: @grand_total }
    end
  end

  private
  
  def set_order
    @order = current_user.orders.pending.first 
    @order ||= current_user.orders.create(status: :pending)
  end

  def set_cart_items
    @cart_items = current_user.cart.line_items.includes(:product)
  end

  def set_order_items
    @order_items = @order.line_items.includes(:product) if @order
  end

  def manage_order_items
    @cart_items.each do |item|
      item.update(itemable: @order)
      cart_order_merger(item) if @order_items.present?
      @order_items.reload
    end
    
  end
  
  def cart_order_merger(item)
    list_items = @order.line_items.includes(:product).where("product_id = ?", item.product_id).sort
    if list_items.length >= 2
      list_item = list_items.first       
      list_item.update(quantity: list_item.quantity + item.quantity)
      item.delete
    end
  end

  def set_order_price
    grand_total = total_bill = total_bill(@order_items)

    if @order.coupon
      coupon = coupon_valid?(@order.coupon.id)
      grand_total = discounted_price(coupon, total_bill)
    end
    
    update_order(total_bill, grand_total)
  end
  
  def update_order(total_bill, grand_total, coupon=nil)
    if coupon
      @order.update(cost: total_bill, total_cost: grand_total, coupon: coupon)

    else
      @order.update(cost: total_bill, total_cost: grand_total)
    
    end
  end

  def total_bill(items)
    total = 0
    if items.present?
      items.each do |item|
        total += (item.price * item.quantity)
      end
    end

    total
  end

  def coupon_valid?(id = nil)
    if id.nil?
      Coupon.active.find_by(title: order_params[:coupon_code])
    
    else
      Coupon.active.find_by_id(id)
    
    end
  end

  def discounted_price(coupon, grand_total)
    (grand_total - (coupon.discount.to_f / 100) * grand_total).to_f
  end

  def order_params
    params.require(:order).permit(:coupon_code)
  end
end
