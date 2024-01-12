# app/models/narudzbina.rb

class Narudzbina < ApplicationRecord
    self.table_name = 'Narudzbina'
    self.record_timestamps = false

    has_many :stavke_narudzbine, foreign_key: 'narudzbina_id', dependent: :destroy
    belongs_to :korisnik, foreign_key: 'korisnik_id'
  
    validates :zakazano_vreme, presence: true
    validates :status_narudzbine, presence: true
    validates :adresa, presence: true
    validates :telefon, presence: true
    validates :email, presence: true
    validates :ime_prezime, presence: true
end