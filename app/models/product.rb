# frozen_string_literal: true

class Product < ApplicationRecord
  # Validations
  validates :name, presence: true, uniqueness: true
  validates :price, numericality: { greater_than: 0 }
  # Associations
  has_many :order_items, as: :itemable
end
