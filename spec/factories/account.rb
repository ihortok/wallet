FactoryBot.define do
  factory :account do
    name { Faker::Hipster.word }
    note { Faker::Lorem.sentence }
    balance { Faker::Number.number(digits: 5) }
    currency_cd { Faker::Number.within(range: 0..3) }
  end
end
