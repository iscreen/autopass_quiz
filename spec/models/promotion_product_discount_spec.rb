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
end
