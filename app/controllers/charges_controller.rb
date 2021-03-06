class ChargesController < BaseController
  before_action :set_order
  before_action :set_items

  def create
    return redirect_to cart_url, alert: "Required quantity is unavailable." if !valid_order?
    
    @amount = @order.total_cost

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer,
      amount: @amount.to_i,
      description: 'Rails Stripe customer',
      currency: 'usd',
    })

    place_order

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

  end

  private

  def valid_order?
    is_valid = true

    @items.each do |item|
      is_valid = false if item.quantity <= 0 || item.quantity > item.product.quantity
    end

    is_valid
  end

  def place_order    
    @items.each do |item|
      item.product.update(quantity: item.product.quantity - item.quantity)
      item.update(price: item.product.price)
    end

    redirect_to orders_url, alert: "Order Placed!" if @order.update(status: :completed) && !current_or_guest_user.guest?

    redirect_to products_url, alert: "Order Placed!" if @order.update(status: :completed) && current_or_guest_user.guest?
  end

  def set_order
    @order = current_or_guest_user.orders.pending.first
    redirect_to products_url, alert: "No Pending Order!" if @order.nil?
  end

  def set_items
    @items = @order.line_items.includes(:product)
    redirect_to cart_url, alert: "Cart is empty!" if @items.empty?
  end

end
