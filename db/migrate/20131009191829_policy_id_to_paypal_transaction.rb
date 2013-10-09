class PolicyIdToPaypalTransaction < ActiveRecord::Migration
  def change
    add_column :paypal_transactions, :policy_id, :integer
  end
end
