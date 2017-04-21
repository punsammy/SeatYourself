class RemoveHoursOfOperationFromRestaurants < ActiveRecord::Migration[5.0]
  def change
    remove_column :restaurants, :hours_of_operation, :text
  end
end
