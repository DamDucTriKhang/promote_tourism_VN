class Food < ApplicationRecord
  has_many :comments
  has_many :food_restaurants
  has_many :restaurants, through: :food_restaurant
  has_one_attached :image
end
