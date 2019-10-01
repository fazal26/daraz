class Cart < ApplicationRecord
  has_many :line_items, as: :itemable

  belongs_to :user
end
