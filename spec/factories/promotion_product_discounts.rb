# frozen_string_literal: true

FactoryBot.define do
  factory :promotion_product_discount do
    sequence(:name) { |n| "Promotion#{n}" }
    start_date { 10.days.ago }
    end_date { 10.days.since }
    association :product, factory: :product_100
    exceed_quantity { 2 }
    amount { 100 }
  end
end
