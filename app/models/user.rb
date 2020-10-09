class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :account_ownerships, dependent: :destroy
  has_many :accounts, through: :account_ownerships
  has_many :operations, through: :accounts
end
