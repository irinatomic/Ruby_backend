class CreateFlowerInProduct < ActiveRecord::Migration[7.1]
  def change
    create_table :flower_in_products do |t|

      t.timestamps
    end
  end
end
