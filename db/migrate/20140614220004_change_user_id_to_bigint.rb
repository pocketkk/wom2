class ChangeUserIdToBigint < ActiveRecord::Migration
  def change
    rename_column :workorders, :phone, :user_id_old
    add_column :workorders, :phone, :bigint
    remove_column :workorders, :user_id_old
  end
end
