# frozen_string_literal: true

class OrderItem < ApplicationRecord
  # Validations
  validates :quantity, numericality: { greater_than: 0 }, if: :product?
  # Associations
  belongs_to :order
  belongs_to :itemable, polymorphic: true

  def product?
    itemable.is_a?(Product)
  end
end
