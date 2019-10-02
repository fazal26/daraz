class LineItemsController < ApplicationController
  before_action :set_cart
  before_action :set_item, only: [:destroy, :update]
  before_action :set_product, only: [:create]

  def create
    line_item = @cart.line_items.new(line_item_params)
    line_item.save!
    puts "____________\n"*10, line_item.inspect

    redirect_to products_path
  end

  def update
    if params[:quantity].to_i <= @item.product.quantity 
      @item.update(quantity: params[:quantity])
      redirect_to cart_path
    else
      render json: { status: 404, message: 'Not enough products available!' }  
    end
  end

  def destroy
    @item.delete
    redirect_to cart_path
  end
  
  private

  def set_cart
    current_user.cart = Cart.new unless current_user.cart
    @cart = current_user.cart
  end

  def set_item
    begin
      @item = @cart.line_items.find_by(id: params[:id])
      
    rescue ActiveRecord::RecordNotFound => e
      render json: {
        error: e.to_s
      }, status: :not_found
    end
  end

  def set_product
    product = Product.find_by(id: line_item_params["product_id"])

    render json: { status: 404, message: 'Product cant be added!' } if product.user_id == current_user.id
  end

  def line_item_params
    params.require(:product).permit(:product_id, :quantity)
  end

end
