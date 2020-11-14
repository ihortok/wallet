class Operation < ApplicationRecord
  TYPES = {
    income: 'income',
    outlay: 'outlay',
    transaction: 'transaction'
  }.freeze

  validates :sum, presence: true
  validates :type, presence: true
  validates :debit_account_id, presence: true, if: :income_or_transaction?
  validates :credit_account_id, presence: true, if: :outlay_or_transaction?

  belongs_to :user
  belongs_to :debit_account, class_name: 'Account', optional: true
  belongs_to :credit_account, class_name: 'Account', optional: true

  scope :by_user, ->(user_id) { where(user_id: user_id) }

  as_enum :type, TYPES[:income] => 0, TYPES[:outlay] => 1, TYPES[:transaction] => 2

  private

  def income_or_transaction?
    type_cd&.zero? || type_cd == 2
  end

  def outlay_or_transaction?
    type_cd == 1 || type_cd == 2
  end
end
