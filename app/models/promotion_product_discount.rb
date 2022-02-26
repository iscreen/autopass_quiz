# frozen_string_literal: true

# Order has product and exceed n quantity discount
class PromotionProductDiscount < PromotionDiscount
  belongs_to :product
  # Validations
  validates :product_id, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :exceed_quantity, numericality: { only_integer: true, greater_than: 0 }
end
