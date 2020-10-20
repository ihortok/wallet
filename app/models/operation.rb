class Operation < ApplicationRecord
  TYPES = {
    income: 'income',
    outlay: 'outlay',
    transaction: 'transaction'
  }.freeze

  validates :sum, presence: true

  belongs_to :debit_account, class_name: 'Account', optional: true
  belongs_to :credit_account, class_name: 'Account', optional: true

  scope :by_user, ->(user_id) { where(user_id: user_id) }

  as_enum :type, TYPES[:income] => 0, TYPES[:outlay] => 1, TYPES[:transaction] => 2
end
