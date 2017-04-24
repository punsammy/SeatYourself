class CreateRestaurantsCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants_categories do |t|
      t.integer :category_id
      t.integer :restaurant_id
    end
  end
end
