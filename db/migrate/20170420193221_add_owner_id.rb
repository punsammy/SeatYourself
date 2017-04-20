class AddOwnerId < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :owner_id, :integer
  end
end
