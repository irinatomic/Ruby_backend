# db/migrate/6_create_flower_in_products.rb

class CreateFlowerInProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :FlowerInProducts do |t|
      t.integer :product_id
      t.integer :flower_id
      t.integer :quantity, null: false

      t.timestamps null: false
    end

    add_foreign_key :FlowerInProducts, :Products, column: :product_id
    add_foreign_key :FlowerInProducts, :Flowers, column: :flower_id
  end
end
