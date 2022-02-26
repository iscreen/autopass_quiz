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
    factory :order_with_item, traits: %i[with_item]
  end
end
