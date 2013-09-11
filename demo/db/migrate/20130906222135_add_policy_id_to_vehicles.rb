class AddPolicyIdToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :policy_id, :integer
  end
end
