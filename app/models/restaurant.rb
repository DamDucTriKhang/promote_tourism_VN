class Restaurant < ApplicationRecord
  has_many :food_restaurants
  has_many :foods, through: :food_restaurants
end
