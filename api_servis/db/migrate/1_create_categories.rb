# db/migrate/1_create_categories.rb

class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :Categories do |t|
      t.string :name, null: false, limit: 75

      t.timestamps null: false
    end

    add_index :categories, :name, unique: true
  end
end

