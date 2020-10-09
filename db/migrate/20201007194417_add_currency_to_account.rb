class AddCurrencyToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :currency_cd, :integer
  end
end
