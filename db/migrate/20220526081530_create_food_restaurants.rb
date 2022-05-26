class CreateFoodRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :food_restaurants do |t|
      t.references :food, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
