# frozen_string_literal: true

# User model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :account_ownerships, dependent: :destroy
  has_many :accounts, through: :account_ownerships
  has_many :operations, dependent: :destroy
  has_one :profile

  validate :email_is_invited

  private

  def email_is_invited
    return unless email

    return if Invitation.find_by(email: email)

    errors.add(:email, 'must be invited to be able to sign up. Please, contact admins.')
  end
end
