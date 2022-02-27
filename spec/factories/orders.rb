# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    state { 0 }
    association :user, factory: :user

    trait :with_item do
      after(:create) do |order, _evaluator|
        order.add_item(FactoryBot.create(:product), 2)
        order.save
      end
    end

    trait :with_product_100 do
      after(:create) do |order, _evaluator|
        order.add_item(FactoryBot.create(:product_100), 1)
        order.save
      end
    end
    trait :with_product_200 do
      after(:create) do |order, _evaluator|
        order.add_item(FactoryBot.create(:product_200), 1)
        order.save
      end
    end
    factory :order_with_item, traits: %i[with_item]
    factory :order_with_product_100, traits: %i[with_product_100]
    factory :order_with_product_200, traits: %i[with_product_200]
  end
end
