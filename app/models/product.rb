class Product < ApplicationRecord
  has_many_attached :images
  belongs_to :user

  cattr_accessor :current_user


  def self.create_product(params)
    puts "XXXXXXXXXXXXXXXx\n"*10, params.inspect
    product = Product.create!({title: params[:title], price: params[:price], user_id: current_user.id})
    product    
  end
end
