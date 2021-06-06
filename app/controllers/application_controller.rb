# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :fetch_accounts, if: :user_signed_in?

  private

  def fetch_accounts
    @accounts = current_user.accounts
  end
end
