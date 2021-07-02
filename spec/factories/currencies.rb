# frozen_string_literal: true

FactoryBot.define do
  factory :currency do
    country { Faker::Number.number(digits: 4) }
    code { Faker::Currency.code }
    symbol { Faker::Address.country }
    icon { :eu }
    rate { 1.0 }
  end
end
