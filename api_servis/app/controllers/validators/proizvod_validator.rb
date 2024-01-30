require 'dry-schema'

ProizvodValidator = Dry::Schema.Params do
    required(:naziv).filled(min_size?: 3)
    required(:opis).filled(min_size?: 3)
    required(:cena).filled(:string)         
    required(:sadrzaj)
end