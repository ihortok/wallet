class AddFieldsToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :currency_cd, :integer
    add_reference :accounts, :user
  end
end
