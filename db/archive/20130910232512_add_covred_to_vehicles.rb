class AddCovredToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :covered, :boolean, :default=>false
  end
end
