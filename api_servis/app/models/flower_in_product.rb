# app/models/flower_in_product.rb

class FlowerInProduct < ApplicationRecord
    self.table_name = 'FlowerInProducts'
    self.record_timestamps = false

    belongs_to :product, foreign_key: 'product_id'
    belongs_to :flower, foreign_key: 'flower_id'
  
    validates :quantity, presence: true, numericality: { only_integer: true }
end
  