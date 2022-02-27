# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PromotionDiscountTakeLimitation, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it do
      should validate_numericality_of(:amount).
        is_greater_than(0)
    end
    it do
      should validate_numericality_of(:discount_amount).
        is_greater_than(0)
    end
    it do
      should validate_numericality_of(:taken_limitation).
        is_greater_than(0)
    end
  end

  it 'is promotion and has discount' do
    promotion = FactoryBot.create(:promotion_discount_take_limitation)
    expect(promotion.is_a?(Promotion)).to eq(true)
    expect(promotion.is_a?(PromotionDiscount)).to eq(true)
  end

  describe '#fulfill?' do
    let(:user) { FactoryBot.create(:user) }
    let(:product_100) { FactoryBot.create(:product_100) }
    let(:promotion) do
      FactoryBot.create(
        :promotion_discount_take_limitation,
        amount: product_100.price * 2
      )
    end
    let(:order) { FactoryBot.create(:order, user: user) }

    it 'order amount is over' do
      order.add_item!(product_100, 2)
      expect(promotion.fulfill?(order)).to be_truthy
    end

    it 'order amount is over but over limitaion' do
      order.add_item!(product_100, 2)
      order.add_item!(promotion)
      expect(promotion.fulfill?(order)).to be_truthy
      order2 = FactoryBot.create(:order, user: user)
      order2.add_item!(product_100, 2)
      expect(promotion.fulfill?(order2)).to be_falsey
    end

    it 'order amount is not enough' do
      order.add_item!(product_100, 1)
      expect(promotion.fulfill?(order)).to be_falsey
    end
  end
end
