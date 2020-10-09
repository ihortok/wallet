class CreateOperations < ActiveRecord::Migration[6.0]
  def change
    create_table :operations do |t|
      t.string :note
      t.belongs_to :account
      t.integer :type_cd

      t.timestamps
    end
  end
end
