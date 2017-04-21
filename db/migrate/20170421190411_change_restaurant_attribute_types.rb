class ChangeRestaurantAttributeTypes < ActiveRecord::Migration[5.0]
  def change
    change_column :restaurants, :phone_number, :string
    change_column :restaurants, :hours_of_operation, :string
  end
end
