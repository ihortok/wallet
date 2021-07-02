# frozen_string_literal: true

require 'rails_helper'

describe AppServices::CreateOperationAndModifyAccounts do
  let(:debit_account) { create(:account) }
  let(:credit_account) { create(:account) }

  context 'when income operation' do
    let(:operation) { build(:operation, :income, debit_account: debit_account) }

    it 'should add an operation and modify a debit_account' do
      service = described_class.new(operation)
      balance = debit_account.balance

      expect { service.call }.to change(Operation, :count).by 1

      expect(debit_account.balance).to eq(balance + operation.sum)
    end
  end

  context 'when outlay operation' do
    let(:operation) { build(:operation, :outlay, credit_account: credit_account) }

    it 'should add an operation and modify a debit_account' do
      service = described_class.new(operation)
      balance = credit_account.balance

      expect { service.call }.to change(Operation, :count).by 1

      expect(credit_account.balance).to eq(balance - operation.sum)
    end
  end

  context 'when transaction operation' do
    let(:operation) { build(:operation, :transaction, debit_account: debit_account, credit_account: credit_account) }

    it 'should add an operation and modify accounts' do
      service = described_class.new(operation)
      debit_account_balance = debit_account.balance
      credit_account_balance = credit_account.balance

      expect { service.call }.to change(Operation, :count).by 1

      expect(debit_account.balance).to eq(debit_account_balance + operation.sum)
      expect(credit_account.balance).to eq(credit_account_balance - operation.sum - operation.fee)
    end
  end

  context 'when different currencies' do
    let(:rate) { 1.5 }
    let(:debit_account) { create(:account, currency: create(:currency, rate: rate)) }
    let(:operation) { build(:operation, :transaction, debit_account: debit_account, credit_account: credit_account) }

    it 'should add an operation and modify accounts with currency conversion' do
      service = described_class.new(operation)
      debit_account_balance = debit_account.balance
      credit_account_balance = credit_account.balance

      expect { service.call }.to change(Operation, :count).by 1

      expect(debit_account.balance).to eq(debit_account_balance + (operation.sum * rate).to_i)
      expect(credit_account.balance).to eq(credit_account_balance - operation.sum - operation.fee)
    end
  end
end
