class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name
      t.string :food_content
      t.string :categories

      t.timestamps
    end
  end
end
