# app/models/category.rb

class Category < ApplicationRecord
    self.table_name = 'Categories'
    self.record_timestamps = false

    has_many :products, foreign_key: 'category_id', dependent: :restrict_with_error
  
    validates :name, presence: true, uniqueness: true, length: { maximum: 75 }
end
  