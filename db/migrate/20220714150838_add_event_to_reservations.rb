class AddEventToReservations < ActiveRecord::Migration[6.1]
  def change
    add_reference :reservations, :event, null: true, foreign_key: true
  end
end
