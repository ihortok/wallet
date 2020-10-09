# frozen_string_literal: true

user = User.create!(email: 'user@user.com', password: 'passwordSTRONG123', password_confirmation: 'passwordSTRONG123')

accounts = [] << Account.create!(
  name: 'GreatBank',
  note: 'Some GreatBank account',
  balance: 435,
  currency: 'usd'
)
accounts << Account.create!(
  name: 'Cash',
  note: 'All the cash of mine',
  balance: 0,
  currency: 'eur'
)

accounts.each { |account| user.accounts << account }

user.account_ownerships.each do |ownership|
  ownership.update(super_owner: true) if ownership.account.in? accounts
end
