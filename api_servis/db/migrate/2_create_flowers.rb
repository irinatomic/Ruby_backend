# db/migrate/2_create_flowers.rb

class CreateFlowers < ActiveRecord::Migration[6.1]
  def change
    create_table :Flowers, { id: false, primary_key: :id } do |t|
      t.primary_key :id
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
