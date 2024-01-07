# db/migrate/0_create_users.rb

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, { id: false } do |t|
      t.primary_key :id
      t.string :username, null: false
      t.string :password, null: false
      t.boolean :admin, null: false
      t.string :email, null: false

      t.timestamps null: false
    end

    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end