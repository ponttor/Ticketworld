class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.text :info
      t.float :cost

      t.timestamps
    end
  end
end
