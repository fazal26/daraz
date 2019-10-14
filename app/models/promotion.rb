class Promotion < ApplicationRecord
  has_one_attached :image 

  validates :title, :expire_at, presence: true

  scope :active, -> { where("expire_at > ? ", Date.today) }
end
