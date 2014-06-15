class AddDeviceTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :device_token, :string
    add_index :users, :device_token, unique: true
  end
end
