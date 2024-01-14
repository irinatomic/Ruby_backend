# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 6) do
  create_table "Cvet", force: :cascade do |t|
    t.string "naziv", null: false
  end

  create_table "CvetUProizvodu", force: :cascade do |t|
    t.integer "kolicina", null: false
    t.integer "proizvod_id"
    t.integer "cvet_id"
  end

  create_table "Kategorija", force: :cascade do |t|
    t.string "naziv", limit: 75, null: false
  end

  create_table "Korisnik", force: :cascade do |t|
    t.string "username", null: false
    t.string "password", null: false
    t.boolean "admin", default: false, null: false
    t.string "email", null: false
  end

  create_table "Narudzbina", force: :cascade do |t|
    t.datetime "zakazano_vreme", precision: nil, null: false
    t.string "status_narudzbine", null: false
    t.string "adresa", null: false
    t.string "telefon", null: false
    t.string "email", null: false
    t.string "ime_prezime", null: false
    t.integer "korisnik_id", null: false
  end

  create_table "Proizvod", force: :cascade do |t|
    t.string "naziv", limit: 75, null: false
    t.string "opis", limit: 255, null: false
    t.integer "cena", null: false
    t.integer "kategorija_id", null: false
  end

  create_table "StavkaNarudzbine", force: :cascade do |t|
    t.integer "kolicina", null: false
    t.integer "jedinicna_cena", null: false
    t.integer "proizvod_id", null: false
    t.integer "narudzbina_id", null: false
  end

  add_foreign_key "CvetUProizvodu", "Cvet", column: "cvet_id"
  add_foreign_key "CvetUProizvodu", "Proizvod", column: "proizvod_id"
  add_foreign_key "Narudzbina", "Korisnik", column: "korisnik_id"
  add_foreign_key "Proizvod", "Kategorija", column: "kategorija_id"
  add_foreign_key "StavkaNarudzbine", "Narudzbina", column: "narudzbina_id"
  add_foreign_key "StavkaNarudzbine", "Proizvod", column: "proizvod_id"
end
