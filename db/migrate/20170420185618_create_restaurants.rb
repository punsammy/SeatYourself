class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.integer :phone_number
      t.text :description
      t.integer :capacity
      
      t.timestamps
    end
  end
end
