class AddStatusToTranscation < ActiveRecord::Migration
  def change
    add_column :paypal_transactions, :status, :string
  end
end
