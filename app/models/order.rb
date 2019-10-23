class Order < ApplicationRecord
  enum status: [ :pending, :completed ]

  belongs_to :user, dependent: :destroy
  belongs_to :coupon, optional: true
  has_many :line_items, as: :itemable, dependent: :destroy
end
