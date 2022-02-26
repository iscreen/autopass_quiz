# frozen_string_literal: true

class Order < ApplicationRecord
  enum state: { init: 0, checked: 1 }

  # Validations
  validates :amount, numericality: { greater_than: 0 }

  # Associations
  belongs_to :user
end
