# frozen_string_literal: true

FactoryBot.define do
  factory :promotion_discount_take_limitation do
    sequence(:name) { |n| "Promotion#{n}" }
    start_date { 10.days.ago }
    end_date { 10.days.since }
    amount { 100 }
    discount_amount { 10 }
    taken_limitation { 1 }
  end
end
