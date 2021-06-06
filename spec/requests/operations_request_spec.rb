require 'rails_helper'

RSpec.describe '/operations', type: :request do
  let(:user) { create(:user, :with_accounts) }

  before do
    sign_in user
  end

  describe 'POST /create' do
    let(:valid_attributes) do
      {
        type_cd: 0,
        debit_account_id: user.accounts.first.id,
        credit_account_id: user.accounts.last.id,
        sum: Faker::Number.number(digits: 4)
      }
    end

    context 'income' do
      it 'creates a new income Operation' do
        balance = user.accounts.first.balance

        expect do
          post operations_url, params: { operation: valid_attributes }
        end.to change(Operation, :count).by(1).and(
          change { user.accounts.first.balance }.from(balance).to(balance + valid_attributes[:sum])
        )
      end
    end

    context 'outlay' do
      it 'creates a new outlay Operation' do
        balance = user.accounts.last.balance

        expect do
          post operations_url, params: { operation: valid_attributes.merge({ type_cd: 1 }) }
        end.to change(Operation, :count).by(1).and(
          change { user.accounts.last.balance }.from(balance).to(balance - valid_attributes[:sum])
        )
      end
    end

    context 'transaction' do
      let(:transaction_attributes) do
        {
          type_cd: 2,
          fee: Faker::Number.number(digits: 2)
        }
      end
      it 'creates a new transaction Operation' do
        debit_account_balance = user.accounts.first.balance
        credit_account_balance = user.accounts.last.balance
        fee = transaction_attributes[:fee]

        expect do
          post operations_url, params: { operation: valid_attributes.merge(transaction_attributes) }
        end.to change(Operation, :count).by(1).and(
          change { user.accounts.first.balance }.from(debit_account_balance)
                                                .to(debit_account_balance + valid_attributes[:sum])
                                                .and(change { user.accounts.last.balance }
                                                .from(credit_account_balance)
                                                .to(credit_account_balance - (valid_attributes[:sum] + fee)))
        )
      end
    end
  end
end
