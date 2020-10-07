class Account < ApplicationRecord
  validates :name, presence: true

  belongs_to :user

  as_enum :currency, uah: 0, usd: 1, eur: 2, pln: 3

  scope :by_user, ->(user) { where(user_id: user.id) }
end
