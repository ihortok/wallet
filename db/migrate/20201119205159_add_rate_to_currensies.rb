class AddRateToCurrensies < ActiveRecord::Migration[6.0]
  def change
    add_column :currencies, :rate, :float
  end
end
