class Coupon < ApplicationRecord
  scope :active, -> { where("expire_at > ? ", Date.current) }
  
  has_many :orders
end
