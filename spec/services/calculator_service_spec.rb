# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculatorService, type: :service do

  describe 'percentage discount' do
    let(:discount_percentage) { 5 }
    let(:product_100) { FactoryBot.create(:product_100) }
    let!(:promotion) do
      FactoryBot.create(
        :promotion_percentage_discount,
        amount: product_100.price * 2,
        discount_percentage: discount_percentage
      )
    end
    let(:order) { FactoryBot.create(:order) }

    it 'order amount enough' do
      order.add_item!(product_100, 2)
      CalculatorService.new(order).perform
      expect(order.discount).to eq(order.amount * discount_percentage / 100)
    end
    it 'order amount not enough' do
      order.add_item!(product_100, 1)
      CalculatorService.new(order).perform
      expect(order.discount).to eq(0)
    end
  end
  # end percentage discount

  describe 'specific product discount' do
    let(:discount_amount) { 10 }
    let(:product_100) { FactoryBot.create(:product_100) }
    let!(:promotion) do
      FactoryBot.create(
        :promotion_product_discount,
        product: product_100,
        discount_amount: discount_amount
      )
    end
    let(:order) { FactoryBot.create(:order) }

    it 'order has specific product' do
      order.add_item!(product_100, 2)
      CalculatorService.new(order).perform
      expect(order.discount).to eq(discount_amount)
    end

    it 'order has specific product but quantity not enough' do
      order.add_item!(product_100, 1)
      CalculatorService.new(order).perform
      expect(order.discount).to eq(0)
    end

    it 'order has no specific product' do
      order.add_item!(FactoryBot.create(:product_200), 1)
      CalculatorService.new(order).perform
      expect(order.discount).to eq(0)
    end
  end
  # end specific product discount

  describe 'gift product discount' do
    let(:product_100) { FactoryBot.create(:product_100) }
    let(:product_200) { FactoryBot.create(:product_200) }
    let!(:promotion) do
      FactoryBot.create(
        :promotion_gift_product,
        amount: 400,
        product: product_200
      )
    end
    let(:order) { FactoryBot.create(:order) }

    it 'order has specific product' do
      order.add_item!(product_200, 3)
      CalculatorService.new(order).perform
      expect(order.discount).to eq(0)
      expect(order.item_exists?(promotion)).to eq(true)
    end

    it 'order has no specific product' do
      order.add_item!(product_100, 1)
      CalculatorService.new(order).perform
      expect(order.discount).to eq(0)
      expect(order.item_exists?(promotion)).to eq(false)
    end
  end
  # end gift product discount

  describe 'discount has limitation' do
    let(:user) { FactoryBot.create(:user) }
    let(:discount_amount) { 5 }
    let(:product_100) { FactoryBot.create(:product_100) }
    let!(:promotion) do
      FactoryBot.create(
        :promotion_discount_take_limitation,
        amount: product_100.price * 2,
        discount_amount: discount_amount
      )
    end
    let(:order) { FactoryBot.create(:order, user: user) }

    it 'order amount enough' do
      order.add_item!(product_100, 2)
      CalculatorService.new(order).perform
      expect(order.discount).to eq(discount_amount)
      expect(order.item_exists?(promotion)).to eq(true)
    end
    it 'order amount not enough' do
      order.add_item!(product_100, 1)
      CalculatorService.new(order).perform
      expect(order.discount).to eq(0)
      expect(order.item_exists?(promotion)).to eq(false)
    end
  end
  # end discount has limitation
end
