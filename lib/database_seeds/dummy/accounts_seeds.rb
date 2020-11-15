# frozen_string_literal: true

module DatabaseSeeds
  module Dummy
    class AccountsSeeds
      def execute
        user = User.find_by(email: 'user@user.com')

        user ||= User.create!(
          email: 'user@user.com',
          password: 'passwordSTRONG123',
          password_confirmation: 'passwordSTRONG123'
        )

        return if user.accounts.size >= 3

        accounts = [] << FactoryBot.create_list(:account, 3)

        accounts.each { |account| user.accounts << account }

        user.account_ownerships.each do |ownership|
          ownership.update(super_owner: true) if ownership.account.in? accounts
        end
      end
    end
  end
end
