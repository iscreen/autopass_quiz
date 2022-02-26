# frozen_string_literal: true

# Order totla amount over n amount percentage discount
class PromotionPercentageDiscount < PromotionDiscount
  # Validations
  validates :amount, numericality: { greater_than: 0 }
  validates :discount_percentage, numericality: { only_integer: true, greater_than: 0 }
end
