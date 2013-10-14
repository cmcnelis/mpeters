class AddVehicleInfoToPayPalTransactions < ActiveRecord::Migration
  def change
    add_column :paypal_transactions, :vehicle_info, :text
  end
end
