# frozen_string_literal: true

# Order exceed x amount discount (has max taken limitaion)
class PromotionDiscountTakeLimitation < PromotionDiscount
  # Validations
  validates :amount, numericality: { greater_than: 0 }
  validates :discount_amount, numericality: { greater_than: 0 }, comparison: { less_than: :amount }
  validates :taken_limitation, numericality: { only_integer: true, greater_than: 0 }

  def fulfill?(order)
    return false if order.amount < amount
    return false if take_count(order) >= taken_limitation

    true
  end

  def discount(order)
    return 0 unless fulfill?(order)

    discount_amount
  end

  private

  # get taken count
  def take_count(order)
    order_items.joins(:order)
      .where(itemable: self)
      .where(order: { user_id: order.user_id })
      .where.not(order: { id: order.id } ).count
  end
end
