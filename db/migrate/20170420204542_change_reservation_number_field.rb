class ChangeReservationNumberField < ActiveRecord::Migration[5.0]
  def change
    rename_column :reservations, :phone_number, :party_size
  end
end
