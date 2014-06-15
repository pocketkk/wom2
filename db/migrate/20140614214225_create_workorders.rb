class CreateWorkorders < ActiveRecord::Migration
  def change
    create_table :workorders do |t|
      t.text :customer, null: false
      t.text :address, null: false
      t.integer :phone, null: false
      t.timestamps
    end
  end
end
