class AddHoursOfOperation < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :hours_of_operation, :integer 
  end
end
