# app/models/order_item.rb

class OrderItem < ApplicationRecord
    self.table_name = 'OrderItems'
    self.record_timestamps = false

    belongs_to :product, foreign_key: 'product_id'
    belongs_to :order, foreign_key: 'order_id'
  
    validates :quantity, presence: true, numericality: { only_integer: true }
    validates :unit_price, presence: true, numericality: { only_integer: true }
end
  