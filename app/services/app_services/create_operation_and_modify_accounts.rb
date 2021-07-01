# frozen_string_literal: true

module AppServices
  # CreateOperationAndModifyAccounts service
  class CreateOperationAndModifyAccounts
    def initialize(operation)
      @operation = operation
      @sum = @operation.sum.to_i
      @fee = @operation.fee.to_i
    end

    def call
      ActiveRecord::Base.transaction do
        @operation.save!
        send("apply_#{@operation.type}")
      end
    rescue StandardError => e
      OpenStruct.new({ success?: false, error: e })
    else
      OpenStruct.new({ success?: true })
    end

    private

    def debit_account
      @debit_account ||= @operation.debit_account
    end

    def credit_account
      @credit_account ||= @operation.credit_account
    end

    def apply_income
      debit_account.update!(balance: debit_account.balance + @sum)
    end

    def apply_outlay
      credit_account.update!(balance: credit_account.balance - @sum)
    end

    def apply_transaction
      convert_currencies
      credit_account.update!(balance: credit_account.balance - (@sum + @fee))
      debit_account.update!(balance: debit_account.balance + (@converted_sum || @sum))
    end

    def convert_currencies
      credit_account_rate = credit_account.currency&.rate
      debit_account_rate = debit_account.currency&.rate

      return unless credit_account_rate && debit_account_rate

      return if credit_account_rate == debit_account_rate

      @converted_sum = (@sum / credit_account_rate * debit_account_rate).to_i
    end
  end
end
