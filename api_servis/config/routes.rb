# config/routes.rb

Rails.application.routes.draw do

  # /cvet -> cvet_controller
  resources :cvet, only: [:index, :show, :create, :update, :destroy]

  # /kategorija -> kategorija_controller
  resources :kategorija, only: [:index, :show, :create, :update, :destroy]

  # /proizvod -> proizvod_controller
  resources :proizvod, only: [:index, :show, :create, :update, :destroy]
  put '/proizvod/promeni-cenu/:id', to: 'proizvod#promeni_cenu', as: :promeni_cenu

  # narudzbina -> narudzbina_controller
  resources :narudzbina, only: [:index, :show, :create, :update, :destroy]
  put '/narudzbina/promeni-status/:id', to: 'narudzbina#promeni_status', as: :promeni_status
    
end
