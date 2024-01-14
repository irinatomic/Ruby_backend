# config/routes.rb

Rails.application.routes.draw do

  # /cvet -> cvet_controller
  resources :cvet, only: [:index, :show, :create, :update, :destroy]

  # /kategorija -> kategorija_controller
  resources :kategorija, only: [:index, :show, :create, :update, :destroy]

  # /proizvod -> proizvod_controller
  resources :proizvod, only: [:index, :show, :create, :update, :destroy] do
    member do
      put 'promeni-cenu/:id', to: 'proizvod#promeni_cenu'
    end
  end

  # narudzbina -> narudzbina_controller
  resources :narudzbina, only: [:index, :show, :create, :update, :destroy] do
    member do
      put 'promeni-status/:id', to: 'narudzbines#promeni_status'
    end
  end
    
end
