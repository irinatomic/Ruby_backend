# app/models/cvet_u_proizvodu.rb

class CvetUProizvodu < ApplicationRecord
    self.table_name = 'CvetUProizvodu'
    self.record_timestamps = false

    belongs_to :proizvod, foreign_key: 'proizvod_id'
    belongs_to :cvet, foreign_key: 'cvet_id'
  
    validates :kolicina, presence: true, numericality: { only_integer: true }
    validates :cvet_id, presence: true
    validates :proizvod_id, presence: true
end
  
  