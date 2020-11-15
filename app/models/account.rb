class Account < ApplicationRecord
  validates :name, presence: true

  has_many :account_ownerships, dependent: :destroy
  has_many :users, through: :account_ownerships
  belongs_to :currency

  scope :by_user, ->(user_id) { joins(:account_ownerships).where('account_ownerships.user_id = ?', user_id) }

  def operations
    Operation.where('debit_account_id = ? OR credit_account_id = ?', id, id)
  end
end
