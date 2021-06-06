# frozen_string_literal: true

# AccountsController
class AccountsController < ApplicationController
  before_action :set_account, only: %i[show edit update destroy]

  def index; end

  def show; end

  def new
    @account = Account.new
  end

  def edit; end

  def create
    @account = Account.new(account_params)

    if @account.save
      AccountOwnership.create!(account_ownership_params(@account))

      redirect_to @account, notice: 'Account was successfully created.'
    else
      render :new
    end
  end

  def update
    if @account.update(account_params)
      redirect_to @account, notice: 'Account was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @account.destroy

    redirect_to accounts_url, notice: 'Account was successfully destroyed.'
  end

  private

  def set_account
    @account = @accounts.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :balance, :note, :currency_id)
  end

  def account_ownership_params(account)
    { user: current_user, account: account, super_owner: true }
  end
end
