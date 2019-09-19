class Product < ApplicationRecord
  has_many_attached :images
  
  has_many :comments, dependent: :destroy

  belongs_to :user

  cattr_accessor :current_user


  def self.create_with_image(params)
    product = Product.new({title: params[:title], price: params[:price], user_id: current_user.id})
    product.images.attach(params[:image])
    product.save && product
  end
end
