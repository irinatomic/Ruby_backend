# app/models/flower.rb

class Flower < ApplicationRecord
    has_many :flower_in_products, foreign_key: 'flower_id', dependent: :restrict_with_error
  
    validates :name, presence: true
end
  