class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user, foreign_key: true
      t.integer :product_id
      t.integer :commentable_id
      t.string :commentable_type
      t.integer :parent_id

      t.timestamps
    end
  end
end
