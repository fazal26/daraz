class ChargesController < ApplicationController
  before_action :set_items, only: [:create]

  def new
  end

  def create
    redirect_to cart_url, alert: "Cart is empty!" if @items.empty?

    if is_cart_valid?
      @amount = 500
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })

      charge = Stripe::Charge.create({
        customer: customer,
        amount: @amount,
        description: 'Rails Stripe customer',
        currency: 'usd',
      })

      place_order
      redirect_to orders_url, notice: "Your Orders has been shipped!"

    else
      redirect_to cart_url
      alert: "Required quantity is unavailable."
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

  end

  private

  def is_cart_valid?
    valid_cart = true

    @items.each do |item|
      valid_cart = false if item.quantity <= 0 || item.quantity > item.product.quantity
    end

    valid_cart
  end

  def place_order
    order = current_user.orders.create
    @items.each do |item|
      item.update(itemable: order)
      item.product.update(quantity: item.product.quantity - item.quantity)
    end
  end

  def set_items
    @items = current_user.cart.line_items.includes(:product)
  end
end

# TODO check from Ahmed Shafiq
