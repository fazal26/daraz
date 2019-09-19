class AddOmniauthToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :provider, :string, limit: 20
    add_column :users, :uid, :string, limit: 100
  end
end
