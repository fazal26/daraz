class Product < ApplicationRecord
  searchkick word_start: [:title]
  
  has_many_attached :images

  has_many :comments, dependent: :destroy

  belongs_to :user

  def search_data
    { title: title,
      price: price
    } 
  end

  def self.create_with_image(user, params)
    product = Product.new({title: params[:title], price: params[:price], user_id: user.id})
    product.images.attach(params[:image])
    product.save && product
  end
end
