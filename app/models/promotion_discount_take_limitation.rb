# frozen_string_literal: true

# Order exceed x amount discount (has max taken limitaion)
class PromotionDiscountTakeLimitation < PromotionDiscount
  # Validations
  validates :amount, numericality: { greater_than: 0 }
  validates :discount_amount, numericality: { greater_than: 0 }, comparison: { less_than: :amount }
  validates :taken_limitation, numericality: { only_integer: true, greater_than: 0 }
end
