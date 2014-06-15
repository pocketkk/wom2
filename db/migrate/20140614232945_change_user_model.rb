class ChangeUserModel < ActiveRecord::Migration
  def change
    remove_column :users, :username
    remove_column :users, :email
  end
end
