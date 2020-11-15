FactoryBot.define do
  factory :currency do
    country { Faker::Number.number(digits: 4) }
    code { Faker::Currency.code }
    symbol { Faker::Address.country }
  end
end
