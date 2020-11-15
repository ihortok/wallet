class AddCurrencyToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_reference :accounts, :currency
  end
end
