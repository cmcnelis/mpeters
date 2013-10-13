class PaypalTransactionsController < ApplicationController
  def index
    @vehicle = Vehicle.find(params[:vehicle_id])
    @transactions = @vehicle.paypal_transactions
  end


  # Method for receipt display
  def receipt
  end

end
