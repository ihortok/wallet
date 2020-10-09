class Operation < ApplicationRecord
  belongs_to :account

  scope :by_user, ->(user_id) { joins(account: [:account_ownerships]).where('account_ownerships.user_id = ?', user_id) }

  as_enum :type, profit: 0, outlay: 1, transaction: 2
end
