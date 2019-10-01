class OrdersController < ApplicationController
  before_action :get_cart, only: [ :place_order ]
  before_action :create_order, only: [ :place_order ]

  def place_order
    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd',
    })

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end

    @cart.line_items.each do |item|
      item.update!(itemable: @order)
    end

    @order
  end

  def show
  end

  def index
    @orders = current_user.orders

  end

  private

  def get_cart
    @cart = current_user.cart
  end

  def create_order
    @order = current_user.orders.create!
  end

end
