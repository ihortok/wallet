FactoryBot.define do
  factory :account do
    name { Faker::Hipster.word }
    note { Faker::Lorem.sentence }
    balance { Faker::Number.number(digits: 5) }
    currency_id { Faker::Number.within(range: 1..7) }
  end
end
