class ChangeColumnTypeForRestaurantHoo < ActiveRecord::Migration[5.0]
  def change
    change_column :restaurants, :hours_of_operation, :text
  end
end
