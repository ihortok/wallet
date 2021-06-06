# frozen_string_literal: true

# Invitation model
class Invitation < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: {
    with: Devise.email_regexp,
    message: 'invalid format'
  }
end
