class RemoveExpirationFromPaypalTransactions < ActiveRecord::Migration
  def change
    remove_column :paypal_transactions, :exp, :string
  end
end
