# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    stage { 0 }
    association :user, factory: :user
  end
end
