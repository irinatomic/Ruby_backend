# app/models/stavka_narudzbine.rb

class StavkaNarudzbine < ApplicationRecord
    self.table_name = 'StavkaNarudzbine'
    self.record_timestamps = false

    belongs_to :proizvod, foreign_key: 'proizvod_id'
    belongs_to :narudzbina, foreign_key: 'narudzbina_id'
  
    validates :kolicina, presence: true, numericality: { only_integer: true }
    validates :jedinicna_cena, presence: true, numericality: { only_integer: true }
    validates :proizvod_id, presence: true
    validates :narudzbina_id, presence: true
end