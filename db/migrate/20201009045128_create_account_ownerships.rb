class CreateAccountOwnerships < ActiveRecord::Migration[6.0]
  def change
    create_table :account_ownerships do |t|
      t.belongs_to :account
      t.belongs_to :user
      t.boolean :super_owner, default: false

      t.timestamps
    end
  end
end
