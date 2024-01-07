# app/models/product.rb

class Product < ApplicationRecord
    self.table_name = 'Products'
    self.record_timestamps = false

    belongs_to :category, foreign_key: 'category_id', optional: false
    has_many :order_items, foreign_key: 'product_id', dependent: :restrict_with_error
    has_many :flower_in_products, foreign_key: 'product_id', dependent: :restrict_with_error
  
    validates :name, presence: true, uniqueness: true, length: { maximum: 75 }
    validates :description, presence: true, length: { maximum: 255 }
    validates :price, presence: true, numericality: { only_integer: true }
end
  