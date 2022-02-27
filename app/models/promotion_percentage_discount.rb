# frozen_string_literal: true

# Order totla amount over n amount percentage discount
class PromotionPercentageDiscount < PromotionDiscount
  # Validations
  validates :amount, numericality: { greater_than: 0 }
  validates :discount_percentage, numericality: { only_integer: true, greater_than: 0 }

  # fulfill promotion
  def fulfill?(order)
    order.amount >= amount
  end

  # promotion discount
  def discount(order)
    return 0 unless fulfill?(order)

    order.amount * discount_percentage / 100
  end
end
