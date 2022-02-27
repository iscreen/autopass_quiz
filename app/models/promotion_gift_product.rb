# frozen_string_literal: true

# Order total amount over x amount gift product
class PromotionGiftProduct < Promotion
  # Associations
  belongs_to :product
  # Validations
  validates :product_id, presence: true
  validates :amount, numericality: { greater_than: 0 }

  # fulfill promotion
  def fulfill?(order)
    order.amount >= amount
  end

  def discount(order)
    0
  end
end
