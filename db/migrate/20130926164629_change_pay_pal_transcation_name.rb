class ChangePayPalTranscationName < ActiveRecord::Migration
  def change
    rename_table :paypaltransactions, :paypal_transactions
  end
end
