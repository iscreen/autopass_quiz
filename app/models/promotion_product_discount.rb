# frozen_string_literal: true

# Order has product and exceed n quantity discount
class PromotionProductDiscount < PromotionDiscount
  belongs_to :product
  # Validations
  validates :product_id, presence: true
  validates :exceed_quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :discount_amount, numericality: { only_integer: true, greater_than: 0 }

  # fulfill promotion
  def fulfill?(order)
    item = order.order_items.select { |item| item.itemable.is_a?(Product) && item.itemable_id == product_id }.first
    return false unless item
    return false if item.quantity < exceed_quantity

    true
  end

  # promotion discount
  def discount(order)
    return 0 unless fulfill?(order)

    discount_amount
  end
end
