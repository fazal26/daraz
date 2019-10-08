class Coupon < ApplicationRecord
  has_many :carts
  
  scope :active, -> { where("expire_at > ? ", Date.today) }
end
