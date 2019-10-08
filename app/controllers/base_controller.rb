class BaseController < ApplicationController
  before_action :authenticate_buyer
  before_action :current_cart

  private
  
  def current_cart
    if user_signed_in? && current_user.cart.present?
      @current_cart = current_user.cart

      if session[:cart_id].present? && session[:cart_id] != current_user.cart.id 
        cart = Cart.find_by(id: session[:cart_id])
        session[:cart_id] = nil
        
        # @current_cart.line_items << cart.line_items

        if cart.present?
          cart.line_items.delete_all
          cart.delete
        end
      end

    elsif session[:cart_id].present?
      cart = Cart.find_by(id: session[:cart_id])

      if cart.present?
        @current_cart = cart

      else
        session[:cart_id] = nil
        @current_cart = Cart.create
        session[:cart_id] = @current_cart.id

      end

    else
      @current_cart = Cart.create
      session[:cart_id] = @current_cart.id

    end
    
    if user_signed_in?
      current_user.cart = @current_cart
      # session[:cart_id] = nil
    end

    @current_cart
  end

  def authenticate_buyer
  end
end
