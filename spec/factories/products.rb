# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product#{n}" }
    sequence(:price) { |_| rand(1...10) * 100 }

    factory :product_100 do
      price { 100 }
    end
    factory :product_200 do
      price { 200 }
    end
    factory :product_300 do
      price { 300 }
    end
  end
end
