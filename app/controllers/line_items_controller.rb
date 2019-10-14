class LineItemsController < BaseController
  before_action :set_item, only: [:destroy, :update]

  def create
    line_item = current_cart.line_items.find_by(product_id: line_item_params['product_id'])
    
    if line_item.present?
      line_item.quantity += line_item_params["quantity"].to_i
    else
      line_item = current_cart.line_items.new(line_item_params)
    end

    if line_item.save
      redirect_to root_path, notice: 'Successfully added to cart'
    else
      redirect_to root_path, alert: '#{line_item.errors.messages[:base][0]}'
    end
  end

  def update
    if params[:quantity].to_i <= @item.product.quantity 
      @item.update(quantity: params[:quantity])
      redirect_to cart_path
    else
      redirect_to products_path, alert: 'Not enough products available!'  
    end
  end

  def destroy
    @item.delete
    
    redirect_to cart_path, notice: 'Item deleted!'
  end
  
  private

  def set_item
    @item = current_cart.line_items.find_by(id: params[:id])

    redirect_to current_cart, alert: "Item not found!" if @item.nil?
  end

  def line_item_params
    params.require(:product).permit(:product_id, :quantity, :price)
  end

end
