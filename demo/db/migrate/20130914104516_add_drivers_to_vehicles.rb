class AddDriversToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :drivers, :string
  end
end
