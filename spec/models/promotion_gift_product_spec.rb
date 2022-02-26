# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PromotionGiftProduct, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:product_id) }
  end

  describe 'associations' do
    it { should belong_to(:product) }
  end

  it 'is promotion but discount' do
    promotion = FactoryBot.create(:promotion_gift_product)
    expect(promotion.is_a?(Promotion)).to eq(true)
    expect(promotion.is_a?(PromotionDiscount)).to eq(false)
  end
end