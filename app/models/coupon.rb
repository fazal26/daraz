class Coupon < ApplicationRecord
  scope :active, -> { where("expire_at > ? ", Date.today) }
end
