# frozen_string_literal: true

FactoryBot.define do
  factory :promotion_gift_product do
    sequence(:name) { |n| "Promotion#{n}" }
    start_date { 10.days.ago }
    end_date { 10.days.since }
    amount { 100 }
    association :product, factory: :product_100
  end
end
