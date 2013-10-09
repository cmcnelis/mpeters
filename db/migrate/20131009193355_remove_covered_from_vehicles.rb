class RemoveCoveredFromVehicles < ActiveRecord::Migration
  def change
    remove_column :vehicles, :covered, :boolean
  end
end
