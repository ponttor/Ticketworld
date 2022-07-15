class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.boolean :available
      t.integer :row
      t.integer :place

      t.timestamps
    end
  end
end
