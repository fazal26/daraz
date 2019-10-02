class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items, as: :itemable
end
