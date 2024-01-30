# db/migrate/5_create_stavke_narudzbine.rb

class CreateStavkeNarudzbine < ActiveRecord::Migration[6.1]
  def change
    create_table :StavkaNarudzbine do |t|
      t.integer :kolicina, null: false
      t.integer :jedinicna_cena, null: false

      # foreign keys
      t.bigint :proizvod_id, null: false
      t.bigint :narudzbina_id, null: false

    end
    # add the foreign key constraint
    add_foreign_key :StavkaNarudzbine, :Proizvod, column: :proizvod_id
    add_foreign_key :StavkaNarudzbine, :Narudzbina, column: :narudzbina_id
  end
end
  