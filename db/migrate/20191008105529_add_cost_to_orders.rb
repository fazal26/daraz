class AddCostToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :cost, :decimal, null: true, precision: 12, scale: 2
    add_column :orders, :total_cost, :decimal, null: true, precision: 12, scale: 2
  end
end
