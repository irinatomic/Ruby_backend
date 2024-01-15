# app/models/cvet.rb

class Cvet < ApplicationRecord
    self.table_name = 'Cvet'
    self.record_timestamps = false

    has_many :cvet_u_proizvodus, class_name: 'CvetUProizvodu', foreign_key: 'cvet_id', dependent: :restrict_with_error
  
    validates :naziv, presence: true
end