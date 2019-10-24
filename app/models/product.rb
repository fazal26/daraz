class Product < ApplicationRecord
  searchkick word_start: [:title]

  belongs_to :user
  
  has_many :comments, dependent: :destroy
  has_many :line_items, dependent: :destroy
  has_many_attached :images

  paginates_per 10

  scope :latest, -> { order(created_at: :desc) }
  scope :available, -> { where("products.quantity > 0") }

  def search_data
    { 
      title: title,
      price: price
    } 
  end
end
