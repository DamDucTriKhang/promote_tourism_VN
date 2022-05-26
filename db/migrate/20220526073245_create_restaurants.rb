class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|
      t.string :address
      t.string :phone
      t.string :name
      
      t.timestamps
    end
  end
end
