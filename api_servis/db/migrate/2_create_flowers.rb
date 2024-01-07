# db/migrate/2_create_flowers.rb

class CreateFlowers < ActiveRecord::Migration[6.1]
  def change
    create_table :Flowers do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
