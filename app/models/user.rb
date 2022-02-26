# frozen_string_literal: true

class User < ApplicationRecord
  # Validations
  validates :name, presence: true, uniqueness: true
  # Association
  has_many :orders
end
