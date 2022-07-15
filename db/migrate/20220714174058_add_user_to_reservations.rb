class AddUserToReservations < ActiveRecord::Migration[6.1]
  def change
    add_reference :reservations, :user, null: true, foreign_key: true
  end
end
