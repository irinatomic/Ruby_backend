# db/migrate/3_create_products.rb

class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :Products, { id: false, primary_key: :id } do |t|
      t.primary_key :id
      t.string :name, null: false, limit: 75
      t.string :description, null: false, limit: 255
      t.integer :price, null: false

      t.timestamps null: false
    end

    add_index :Products, :name, unique: true
    add_reference :Products, :category, null: false, foreign_key: { to_table: :Categories }
  end
end
