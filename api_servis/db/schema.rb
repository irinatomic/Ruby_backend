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
  create_table "Cvet", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "naziv", null: false
  end

  create_table "CvetUProizvodu", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "kolicina", null: false
    t.bigint "proizvod_id"
    t.bigint "cvet_id"
    t.index ["cvet_id"], name: "fk_rails_682ceb0154"
    t.index ["proizvod_id"], name: "fk_rails_ce2c4fa7f5"
  end

  create_table "Kategorija", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "naziv", limit: 75, null: false
  end

  create_table "Korisnik", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest", null: false
    t.boolean "admin", default: false, null: false
    t.string "email", null: false
  end

  create_table "Narudzbina", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.datetime "zakazano_vreme", precision: nil, null: false
    t.string "status_narudzbine", null: false
    t.string "adresa", null: false
    t.string "telefon", null: false
    t.string "email", null: false
    t.string "ime_prezime", null: false
    t.bigint "korisnik_id", null: false
    t.index ["korisnik_id"], name: "fk_rails_224dadcf2a"
  end

  create_table "Proizvod", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "naziv", limit: 75, null: false
    t.string "opis", null: false
    t.integer "cena", null: false
    t.bigint "kategorija_id", null: false
    t.index ["kategorija_id"], name: "fk_rails_e607b8a81b"
  end

  create_table "StavkaNarudzbine", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "kolicina", null: false
    t.integer "jedinicna_cena", null: false
    t.bigint "proizvod_id", null: false
    t.bigint "narudzbina_id", null: false
    t.index ["narudzbina_id"], name: "fk_rails_cc84f5524c"
    t.index ["proizvod_id"], name: "fk_rails_589e276fb3"
  end

  add_foreign_key "CvetUProizvodu", "Cvet", column: "cvet_id"
  add_foreign_key "CvetUProizvodu", "Proizvod", column: "proizvod_id"
  add_foreign_key "Narudzbina", "Korisnik", column: "korisnik_id"
  add_foreign_key "Proizvod", "Kategorija", column: "kategorija_id"
  add_foreign_key "StavkaNarudzbine", "Narudzbina", column: "narudzbina_id"
  add_foreign_key "StavkaNarudzbine", "Proizvod", column: "proizvod_id"
end
