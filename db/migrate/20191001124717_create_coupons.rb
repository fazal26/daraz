class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :title
      t.decimal :discount
      t.date :expire_at

      t.timestamps
    end
  end
end
