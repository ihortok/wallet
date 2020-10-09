class Account < ApplicationRecord
  validates :name, presence: true

  has_many :account_ownerships, dependent: :destroy
  has_many :users, through: :account_ownerships

  as_enum :currency, uah: 0, usd: 1, eur: 2, pln: 3

  scope :by_user, ->(user_id) { joins(:account_ownerships).where('account_ownerships.user_id = ?', user_id) }
end
