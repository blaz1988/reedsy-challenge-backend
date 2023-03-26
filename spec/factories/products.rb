# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:code) { |n| "CODE#{n}" }
    sequence(:name) { |n| "Product Name #{n}" }
    price { Faker::Commerce.price(range: 0.01..9999.99, as_string: false) }
  end
end
