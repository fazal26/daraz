class Order < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :coupon, optional: true

  has_many :line_items, as: :itemable, dependent: :destroy

  enum status: { pending: 0, completed: 1 }
end
