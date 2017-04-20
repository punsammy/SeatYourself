class ChangeOwnerToUser < ActiveRecord::Migration[5.0]
  def change
    rename_column :restaurants, :owner_id, :user_id
  end
end
