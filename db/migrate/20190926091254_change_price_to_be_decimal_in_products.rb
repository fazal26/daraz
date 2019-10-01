class ChangePriceToBeDecimalInProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :price, :decimal, null: false, precision: 12, scale: 2
  end
end
