class AddPreviousDeductivleToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :previous_deductible, :integer
  end
end
