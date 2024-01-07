# db/migrate/4_create_orders.rb

class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :Orders do |t|
      t.datetime :scheduled_time, null: false
      t.string :order_status, null: false
      t.string :address, null: false
      t.string :phone, null: false
      t.string :email, null: false
      t.string :full_name, null: false

      t.timestamps null: false
    end

    add_reference :Orders, :user, null: false, foreign_key: { to_table: :Users }
  end
end
