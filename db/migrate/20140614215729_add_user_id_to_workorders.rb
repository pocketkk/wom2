class AddUserIdToWorkorders < ActiveRecord::Migration
  def change
    add_column :workorders, :user_id, :integer
  end
end
