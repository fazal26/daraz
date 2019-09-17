module ProductsHelper
  def product_image(product)
    if product.images.attached?
      product.images.first
    else
      image_path('user.png')
    end
  end
end
