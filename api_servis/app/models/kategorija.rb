# app/models/kategorija.rb

class Kategorija < ApplicationRecord
    self.table_name = 'Kategorija'
    self.record_timestamps = false

    has_many :proizvods, class_name: 'Proizvod', foreign_key: 'kategorija_id', dependent: :restrict_with_error
  
    validates :naziv, presence: true, uniqueness: true, length: { maximum: 75 }
end  