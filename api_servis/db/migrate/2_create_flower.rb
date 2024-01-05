class CreateFlower < ActiveRecord::Migration[7.1]
  def change
    create_table :flowers do |t|

      t.timestamps
    end
  end
end
