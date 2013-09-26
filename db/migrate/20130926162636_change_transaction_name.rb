class ChangeTransactionName < ActiveRecord::Migration
  def change
    remove_index :transactions, name: "index_transactions_on_vehicle_id"
    rename_table :transactions, :paypaltransactions
  end
end
