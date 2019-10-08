class AddPriceToLineItem < ActiveRecord::Migration[5.2]
  def change
    add_column :line_items, :price, :decimal, null: true, precision: 12, scale: 2
  end
end
