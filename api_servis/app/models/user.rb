# app/models/user.rb

class User < ApplicationRecord
    has_many :orders, foreign_key: 'user_id', dependent: :destroy
  
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true
    validates :admin, inclusion: { in: [true, false] }
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Not an email address" }
end
  