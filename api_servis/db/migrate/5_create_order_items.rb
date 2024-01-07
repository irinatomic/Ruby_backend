# db/migrate/5_create_order_items.rb

class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :OrderItems, { id: false, primary_key: [:order_id, :product_id] } do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :quantity, null: false
      t.integer :unit_price, null: false

      t.timestamps null: false
    end

    add_foreign_key :OrderItems, :Orders, column: :order_id
    add_foreign_key :OrderItems, :Products, column: :product_id
  end
end
