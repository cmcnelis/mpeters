class PaypalTransactionsController < ApplicationController
  def index
    @policy = Policy.find(params[:policy_id])
    @transactions = @policy.paypal_transactions
  end


  # Method for receipt display
  def receipt
  end

end
