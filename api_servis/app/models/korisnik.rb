# app/models/korisnik.rb

class Korisnik < ApplicationRecord
    self.table_name = 'Korisnik'
    self.record_timestamps = false

    has_many :narudzbine, class_name: 'Narudzbina', foreign_key: 'korisnik_id', dependent: :destroy
  
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true
    validates :admin, inclusion: { in: [true, false] }
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Nije ispravna email adresa" }
end



  