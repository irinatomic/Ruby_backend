require 'dry-schema'

NarudzbinaValidator = Dry::Schema.Params do
    required(:zakazano_vreme).filled(:string)
    required(:adresa).filled(:string)
    required(:telefon).filled(:string)
    required(:email).filled(:string)
    required(:ime_prezime).filled(:string)
    required(:sadrzaj)
end