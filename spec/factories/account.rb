# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    currency

    name { Faker::Hipster.word }
    note { Faker::Lorem.sentence }
    balance { Faker::Number.number(digits: 5) }

    after(:create) do |account|
      create(:account_ownership, account: account)
    end
  end
end
