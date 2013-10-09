class RemoveVehiclesFromPaypalTransactions < ActiveRecord::Migration
  def change
    remove_column :paypal_transactions, :vehicle_id, :integer
  end
end
