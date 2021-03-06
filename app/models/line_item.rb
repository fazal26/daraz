class LineItem < ApplicationRecord
  validate :check_product_quantity

  belongs_to :itemable, polymorphic: true
  belongs_to :product
  
  def check_product_quantity
    if self.quantity > self.product.quantity
      self.errors.add(:base, "Quantity is not available")
      # throw :abort
      # raise ActiveRecord::RecordInvalid.new(self)
    end
  end

end
