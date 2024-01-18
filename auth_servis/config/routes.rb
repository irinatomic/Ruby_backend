# config/routes.rb

Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  post '/register', to: 'auth#register'
  post '/login', to: 'auth#login'
end
