class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :vin
      t.date :start_date
      t.date :expr_date
      t.string :make
      t.string :model
      t.string :color
      t.integer :deductable

      t.timestamps
    end
  end
end
