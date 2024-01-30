# db/migrate/4_create_narudzbine.rb

class CreateNarudzbine < ActiveRecord::Migration[6.1]
  def change
    create_table :Narudzbina do |t|
      t.datetime :zakazano_vreme, null: false
      t.string :status_narudzbine, null: false
      t.string :adresa, null: false
      t.string :telefon, null: false
      t.string :email, null: false
      t.string :ime_prezime, null: false

      # foreign keys
      t.bigint :korisnik_id, null: false

    end
    # add the foreign key constraint
    add_foreign_key :Narudzbina, :Korisnik, column: :korisnik_id
  end
end