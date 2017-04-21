class AddSpecialToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :special, :string
  end
end
