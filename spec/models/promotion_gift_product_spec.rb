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


  describe '#fulfill?' do
    let(:product_100) { FactoryBot.create(:product_100) }
    let(:product_200) { FactoryBot.create(:product_200) }
    let(:promotion) do
      FactoryBot.create(
        :promotion_gift_product,
        amount: 400,
        product: product_200
      )
    end
    let(:order) { FactoryBot.create(:order) }

    it 'order has product and amount enough' do
      order.add_item!(product_200, 3)
      expect(promotion.fulfill?(order)).to be_truthy
    end

    it 'order has product but amount not enough' do
      order.add_item!(product_200, 1)
      expect(promotion.fulfill?(order)).to be_falsey
    end

    it 'order no promotion product' do
      order.add_item!(product_100, 1)
      expect(promotion.fulfill?(order)).to be_falsey
    end
  end

  describe '#discount' do
    let(:product_100) { FactoryBot.create(:product_100) }
    let(:product_200) { FactoryBot.create(:product_200) }
    let(:promotion) do
      FactoryBot.create(
        :promotion_gift_product,
        amount: 400,
        product: product_200
      )
    end
    let(:order) { FactoryBot.create(:order) }

    it 'fulfill promotion but it\'s gift no discount' do
      order.add_item!(product_200, 3)
      expect(promotion.discount(order)).to eq(0)
    end

    it 'no discount' do
      order.add_item!(product_100, 1)
      expect(promotion.discount(order)).to eq(0)
    end
  end
end