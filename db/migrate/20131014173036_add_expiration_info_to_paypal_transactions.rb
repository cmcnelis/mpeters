class AddExpirationInfoToPaypalTransactions < ActiveRecord::Migration
  def change
    add_column :paypal_transactions, :expr_month, :string
    add_column :paypal_transactions, :expr_year, :string
  end
end
