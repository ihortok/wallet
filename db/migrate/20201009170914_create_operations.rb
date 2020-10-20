class CreateOperations < ActiveRecord::Migration[6.0]
  def change
    create_table :operations do |t|
      t.integer :type_cd
      t.belongs_to :debit_account
      t.belongs_to :credit_account
      t.integer :sum
      t.integer :fee
      t.string :note
      t.belongs_to :user

      t.timestamps
    end
  end
end
