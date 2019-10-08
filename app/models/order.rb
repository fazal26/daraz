class Order < ApplicationRecord
  enum status: [ :pending, :completed ]

  belongs_to :user
  has_many :line_items, as: :itemable, dependent: :destroy
end
