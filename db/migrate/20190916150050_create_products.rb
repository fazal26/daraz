class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title, null: false, limit: 100
      t.decimal :price, null: false 
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
