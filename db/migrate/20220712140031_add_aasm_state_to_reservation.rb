class AddAasmStateToReservation < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :aasm_state, :string
  end
end
