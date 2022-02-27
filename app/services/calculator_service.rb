# frozen_string_literal: true

# CalculatorService
class CalculatorService
  def initialize(order)
    @order = order
  end

  def perform
    check_promotions
    calculate_discount
  end

  private

  # check order's promotions
  def check_promotions
    return if @order.paid?

    promotions = Promotion.availables
    promotions.find_each do |promotion|
      next unless promotion.fulfill?(@order)
      next if @order.item_exists?(promotion)

      @order.add_item(promotion)
    end
    @order.checking!
  end

  # calculate order's discount
  def calculate_discount
    discount = @order.promotions.map { |promotion| promotion.discount(@order) }.sum
    @order.update(discount: @order.amount > discount ? discount : @order.amount)
  end
end
