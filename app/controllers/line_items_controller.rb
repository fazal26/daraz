class LineItemsController < ApplicationController
  before_action :set_cart
  before_action :set_item, only: [:destroy, :update]
  before_action :set_product, only: [:create]

  def create
    line_item = @cart.line_items.new(line_item_params)
    if line_item.save
      redirect_to root_path, notice: 'Successfully added to cart'
    else  
      redirect_to root_path, alert: 'Error adding product!'
    end
  end

  def update
    if params[:quantity].to_i <= @item.product.quantity 
      @item.update(quantity: params[:quantity])
    else
      redirect_to products_path, alert: 'Not enough products available!'  
    end

    redirect_to cart_path
  end

  def destroy
    @item.delete
    redirect_to cart_path, notice: 'Item deleted!'
  end
  
  private

  def set_cart
    @cart = current_user.cart
  end

  def set_item
    @item = @cart.line_items.find_by(id: params[:id])
    redirect_to @cart, alert: "Item not found!" if @item.nil?
  end

  def set_product
    product = Product.find_by(id: line_item_params["product_id"])
    redirect_to products_path, notice: 'Product cant be added!' if product.user_id == current_user.id
  end

  def line_item_params
    params.require(:product).permit(:product_id, :quantity)
  end

end
