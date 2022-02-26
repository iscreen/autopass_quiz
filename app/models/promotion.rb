# frozen_string_literal: true

class Promotion < ApplicationRecord
  # Validations
  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true, comparison: { greater_than: :start_date }
  # Associations
  has_many :order_items, as: :itemable
end
