# db/migrate/0_create_korisnici.rb

class CreateKorisnici < ActiveRecord::Migration[6.1]
  def change
    create_table :Korisnik do |t|
      t.string :username, null: false
      t.string :password, null: false
      t.boolean :admin, default: false, null: false
      t.string :email, null: false

      t.timestamps null: false
    end
  end
end
