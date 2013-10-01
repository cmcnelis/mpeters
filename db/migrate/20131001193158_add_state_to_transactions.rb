class AddStateToTransactions < ActiveRecord::Migration
  def change
    add_column :paypal_transactions, :state, :string
  end
end
