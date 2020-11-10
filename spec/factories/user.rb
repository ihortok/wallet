FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :with_accounts do
      after(:create) do |user|
        2.times { create(:account_ownership, user_id: user.id) }
      end
    end
  end
end
