class RecreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :vin
      t.date :start_date
      t.date :expr_date
      t.string :make
      t.string :model
      t.string :color
      t.integer :deductible
      t.integer :policy_id
      t.integer :previous_deductible

      t.timestamps
        end
    end
end
