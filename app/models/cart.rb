class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :line_items, as: :itemable
end
