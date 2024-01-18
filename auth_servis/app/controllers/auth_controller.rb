# auth controller

class AuthController < ApplicationController
  
  # POST /register
  def register
    user = Korisnik.new(user_params)
    if user.save
      token = encode_token({ user_id: user.id })
      render json: { token: token, id: user.id }, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # POST /login
  def login
    user = Korisnik.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { token: token, id: user.id }
    else
      render json: { message: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials.jwt_secret_key)
  end
end
  