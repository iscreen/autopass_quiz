# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:order_items) }
  end

  describe 'add_item' do
    describe 'for Product' do
      it 'without bang' do
        order = Order.new(user: FactoryBot.create(:user))
        order.add_item(FactoryBot.create(:product_100), 2)
        order.save
        expect(order.valid?).to eq(true)
      end
      it 'with bang' do
        order = Order.new(user: FactoryBot.create(:user))
        order.add_item!(FactoryBot.create(:product_100), 2)
        expect(order.valid?).to eq(true)
      end
    end
    describe 'for Promotion' do
      it 'without bang' do
        order = Order.new(user: FactoryBot.create(:user))
        order.add_item(FactoryBot.create(:promotion_product_discount))
        order.save
        expect(order.valid?).to eq(true)
      end
      it 'with bang' do
        order = Order.new(user: FactoryBot.create(:user))
        order.add_item!(FactoryBot.create(:promotion_product_discount))
        expect(order.valid?).to eq(true)
      end
    end
  end

  it 'should has amount' do
    product = FactoryBot.create(:product_100)
    quantity = 2
    order = Order.new(user: FactoryBot.create(:user))
    order.add_item!(product, quantity)
    expect(order.amount).to eq(product.price * quantity)
  end
end
