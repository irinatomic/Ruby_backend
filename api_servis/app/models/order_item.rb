# app/models/order_item.rb

class OrderItem < ApplicationRecord
    belongs_to :product, foreign_key: 'product_id'
    belongs_to :order, foreign_key: 'order_id'
  
    validates :quantity, presence: true, numericality: { only_integer: true }
    validates :unit_price, presence: true, numericality: { only_integer: true }
end
  