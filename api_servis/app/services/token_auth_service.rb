class TokenAuthService
    def initialize(token)
      @token = token
    end
  
    def authenticate_admin
      begin
        payload = decode_token
        user = Korisnik.find_by_id(payload[:user_id])
        user.admin?
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
        false
      end
    end

    def authenticate_user
      begin
        payload = decode_token
        user = Korisnik.find_by_id(payload[:user_id])
        !user.admin
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
        false
      end
    end
  
    private
  
    def decode_token
      JWT.decode(@token, Rails.application.credentials.jwt_secret_key, true, algorithm: 'HS256')[0].symbolize_keys
    end
  end
  