class BaseController < ApplicationController
  before_action :authenticate_buyer
  before_action :current_or_guest_user

  def current_or_guest_user
    if current_user && session[:guest_user_id] && session[:guest_user_id] != current_user.id
      if session[:guest_user_id].present?
        session_guest_user = User.find_by(id: session[:guest_user_id])
        session_guest_user.delete if session_guest_user.present?
      end 
      @user = current_user
    else
      @user = guest_user
    end

    @user
  end
  
  def guest_user(with_retry = true)
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

    rescue ActiveRecord::RecordNotFound
    session[:guest_user_id] = nil
    guest_user if with_retry
  end

  def current_cart
    @current_cart ||= set_cart
  end

  def set_cart
    if current_or_guest_user.has_role?(:buyer)
      guest_cart = Cart.find_by(id: session[:guest_cart_id]) if session[:guest_cart_id].present?
      if user_signed_in?
        current_user.create_cart if !current_user.cart.present?
        guest_cart.present? ? sync_signed_in_user_cart(guest_cart) : current_user.cart
      else
        cart = guest_cart || @user.create_cart
        session[:guest_cart_id] = cart.id
        cart
      end
    end
  end

  private

  def sync_signed_in_user_cart(guest_cart)
    if guest_cart.id != current_user.cart.id
      session[:guest_cart_id] = nil
      current_user.cart.line_items << guest_cart.line_items
      guest_cart.line_items.delete_all
      guest_cart.delete
    end

    current_user.cart
  end

  def authenticate_buyer
    user_signed_in? && !current_user.has_role?(:buyer)
  end

  def create_guest_user
    user = User.new(username: "guest", email: "guest_#{Time.now.to_i}#{rand(100)}@daraz.pk", guest: true)
    user.add_role(:buyer)
    user.save!(validate: false)
    session[:guest_user_id] = user.id
    user
  end
end
