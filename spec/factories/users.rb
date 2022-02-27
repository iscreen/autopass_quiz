# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    initialize_with { new.class.find_or_initialize_by(name: name) }
    sequence(:name) { |n| "User#{n}" }
  end
end
