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
end
