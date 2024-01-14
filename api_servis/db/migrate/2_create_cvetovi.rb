# db/migrate/2_create_cvetovi.rb

class CreateCvetovi < ActiveRecord::Migration[6.1]
  def change
    create_table :Cvet do |t|
      t.string :naziv, null: false

    end
  end
end

