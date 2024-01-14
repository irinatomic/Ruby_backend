# db/migrate/1_create_kategorije.rb

class CreateKategorije < ActiveRecord::Migration[6.1]
  def change
    create_table :Kategorija do |t|
      t.string :naziv, null: false, limit: 75

    end
  end
end