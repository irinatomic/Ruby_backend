# db/migrate/3_create_proizvodi.rb

class CreateProizvodi < ActiveRecord::Migration[6.1]
  def change
    create_table :Proizvod do |t|
      t.string :naziv, null: false, limit: 75
      t.string :opis, null: false, limit: 255
      t.integer :cena, null: false

      # foreign keys
      t.integer :kategorija_id, null: false

    end
    # add the foreign key constraint
    add_foreign_key :Proizvod, :Kategorija, column: :kategorija_id
  end
end
