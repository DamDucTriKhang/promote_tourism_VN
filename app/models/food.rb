class Food < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  has_many :comments
  has_many :food_restaurants
  has_many :restaurants, through: :food_restaurant
  has_one_attached :image
end
