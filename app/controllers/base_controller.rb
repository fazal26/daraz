class BaseController < ApplicationController
  before_action :authenticate_buyer
  before_action :current_or_guest_user
  before_action :current_cart

  def current_or_guest_user
    if current_user && session[:guest_user_id] && session[:guest_user_id] != current_user.id
      if session[:guest_user_id].present?
        session_guest_user = User.find_by(id: session[:guest_user_id]) 
        session_guest_user.present? && session_guest_user.delete
      end 
      @user = current_user
    else
      @user = guest_user
    end

    @user
  end
  
  def guest_user(with_retry = true)
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

    rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
    session[:guest_user_id] = nil
    guest_user if with_retry
  end

  def current_cart
    if user_signed_in? && current_user.cart.present?
      @current_cart = current_user.cart
      if session[:cart_id].present? && session[:cart_id] != current_user.cart.id 
        cart = Cart.find_by(id: session[:cart_id])
        session[:cart_id] = nil
        if cart.present?
          @current_cart.line_items << cart.line_items
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
    @current_cart.user = @user
    @current_cart
  end

  private

  def authenticate_buyer
    user_signed_in? && !current_user.has_role?(:buyer)
  end

  def create_guest_user
    user = User.new(username: "guest", email: "guest_#{Time.now.to_i}#{rand(100)}@daraz.pk", guest: true)
    user.add_role(:buyer)
    user.save!(:validate => false)
    session[:guest_user_id] = user.id
    user
  end
end
