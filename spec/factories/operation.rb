# frozen_string_literal: true

FactoryBot.define do
  factory :operation do
    user

    sum { Faker::Number.number(digits: 4) }

    trait :income do
      type { :income }
      debit_account { create(:account) }
    end

    trait :outlay do
      type { :outlay }
      credit_account { create(:account) }
    end

    trait :transaction do
      type { :transaction }
      debit_account { create(:account) }
      credit_account { create(:account) }
      fee { Faker::Number.number(digits: 2) }
    end
  end
end
