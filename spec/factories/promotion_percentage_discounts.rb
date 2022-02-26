# frozen_string_literal: true

FactoryBot.define do
  factory :promotion_percentage_discount do
    sequence(:name) { |n| "Promotion#{n}" }
    start_date { 10.days.ago }
    end_date { 10.days.since }
    amount { 100 }
    discount_percentage { 10 }
  end
end
