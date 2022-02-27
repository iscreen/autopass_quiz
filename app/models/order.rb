# frozen_string_literal: true

class Order < ApplicationRecord
  # Callbacks
  before_validation :calculate_amount

  enum state: { init: 0, checking: 1, paid: 2 }

  # Validations
  validates :amount, numericality: { greater_than: 0 }, if: :product_items?

  # Associations
  belongs_to :user
  has_many :order_items, autosave: true
  has_many :products, through: :order_items, source: :itemable,
    source_type: 'Product'
  has_many :promotions, through: :order_items, source: :itemable,
    source_type: 'Promotion'

  def add_item(item, quantity = 0)
    return if paid?

    order_item = order_items.select { |oi| oi.itemable == item }.first
    order_items.build(itemable: item, quantity: quantity) unless order_item
  end

  def add_item!(item, quantity = 0)
    return if paid?

    oi = add_item(item, quantity)
    save!
  end

  def product_items?
    order_items.each do |oi|
      return true if oi.itemable.is_a?(Product)
    end
    false
  end

  private

  def calculate_amount
    return if paid?
    return unless product_items?

    self.amount = order_items.map do |oi|
      oi.itemable.is_a?(Product) ? oi.itemable.price * oi.quantity : 0
    end.sum
  end
end
