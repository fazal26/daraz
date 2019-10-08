class CreatePromotions < ActiveRecord::Migration[5.2]
  def change
    create_table :promotions do |t|
      t.string :title
      t.date :expire_at

      t.timestamps
    end
  end
end
