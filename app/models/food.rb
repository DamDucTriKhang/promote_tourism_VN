class Food < ApplicationRecord
  belongs_to :category
  has_many :comments
  has_many :food_restaurants
  has_many :restaurants, through: :food_restaurant
end
