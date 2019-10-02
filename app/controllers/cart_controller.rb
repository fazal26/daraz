class CartController < ApplicationController
  before_action :set_cart, only: [:show, :clear]
  
  def show
    @cart_items = @cart.line_items.includes(:product)
  end

  def clear
    @cart.line_items.delete_all
  end

  private

  def set_cart
    puts "--------------\n"*10, current_user.cart.inspect

    @cart = current_user.cart
  end
end

#TODO fix and manage stripe
#TODO fix and manage quantities
#TODO fix and manage coupons
#TODO restrict comment action
#TODO fix comment image
#TODO set params name :product to line_item
#TODO rescue raise when product item not found
#TODO coupons 
#TODO logged out cart


