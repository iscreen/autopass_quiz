# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PromotionProductDiscount, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:product_id) }
    it do
      should validate_numericality_of(:exceed_quantity).
        is_greater_than(0)
    end
    describe 'associations' do
      it { should belong_to(:product) }
    end
  end

  it 'is promotion and has discount' do
    promotion = FactoryBot.create(:promotion_percentage_discount)
    expect(promotion.is_a?(Promotion)).to eq(true)
    expect(promotion.is_a?(PromotionDiscount)).to eq(true)
  end

  describe '#fulfill?' do
    let(:product_100) { FactoryBot.create(:product_100) }
    let(:promotion) do
      FactoryBot.create(
        :promotion_product_discount,
        product: product_100
      )
    end
    let(:order) { FactoryBot.create(:order) }

    it 'order quantity is over' do
      order.add_item!(product_100, 2)
      expect(promotion.fulfill?(order)).to be_truthy
    end

    it 'order quantity is less' do
      order.add_item!(product_100, 1)
      expect(promotion.fulfill?(order)).to be_falsey
    end
  end

  describe '#discount' do
    let(:discount_amount) { 10 }
    let(:product_100) { FactoryBot.create(:product_100) }
    let(:promotion) do
      FactoryBot.create(
        :promotion_product_discount,
        product: product_100,
        discount_amount: discount_amount
      )
    end
    let(:order) { FactoryBot.create(:order) }

    it 'has discount' do
      order.add_item!(product_100, 2)
      expect(promotion.discount(order)).to eq(discount_amount)
    end

    it 'no discount' do
      order.add_item!(product_100, 1)
      expect(promotion.discount(order)).to eq(0)
    end
  end
end
