class Product < ApplicationRecord
  searchkick word_start: [:title]
  belongs_to :user
  
  has_many :comments, dependent: :destroy
  has_many :line_items 
  has_many_attached :images
  
  def search_data
    { 
      title: title,
      price: price
    } 
  end

  def self.create_with_image(user, params)
    product = Product.new({title: params[:title], price: params[:price], user_id: user.id, quantity: params[:quantity], description: params[:description]})
    product.images.attach(params[:image])
    product.save && product
  end
end
