# app/models/proizvod.rb

class Proizvod < ApplicationRecord
    self.table_name = 'Proizvod'
    self.record_timestamps = false

    belongs_to :kategorija, foreign_key: 'kategorija_id'
    has_many :stavke_narudzbine, foreign_key: 'proizvod_id', dependent: :restrict_with_error
    has_many :cvetovi_u_proizvodu, foreign_key: 'proizvod_id', dependent: :restrict_with_error
  
    validates :naziv, presence: true, uniqueness: true, length: { maximum: 75 }
    validates :opis, presence: true, length: { maximum: 255 }
    validates :cena, presence: true, numericality: { only_integer: true }
    validates :kategorija_id, presence: true
end
  
