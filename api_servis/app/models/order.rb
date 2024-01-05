# app/models/order.rb

class Order < ApplicationRecord
    has_many :order_items, foreign_key: 'order_id', dependent: :destroy
    belongs_to :user, foreign_key: 'user_id'
  
    validates :scheduled_time, presence: true
    validates :order_status, presence: true
    validates :address, presence: true
    validates :phone, presence: true
    validates :email, presence: true
    validates :full_name, presence: true
end
  