require 'paypal-sdk-rest'
require 'paypal_transaction'

class PayPalHelper
    include PayPal::SDK::REST

    def initialize(payment_info, policy)
        Rails.logger.debug "Creating PayPalHelper >> #{payment_info.inspect}"
        @payment_info = payment_info
        @policy = policy
    end

    def make_payment

            # Currently just sending dummy data while under developlment
            # Build Payment object
            @payment = Payment.new({
                :intent => "sale",
                :payer => {
                    :payment_method => "credit_card",
                    :funding_instruments => [{
                    :credit_card => {
                        :type => "visa",
                        :number => "4417119669820331",
                        :expire_month => "11",
                        :expire_year => "2018",
                        :cvv2 => "874",
                        :first_name => "Joe",
                        :last_name => "Shopper",
                    :billing_address => {
                      :line1 => "52 N Main ST",
                      :city => "Johnstown",
                      :state => "OH",
                      :postal_code => "43210",
                      :country_code => "US" }}}]},
                      :transactions => [{
                            :item_list => {
                                :items => [{
                                    :name => "Deductible Coverage",
                                    :sku => policy.vehicle[0].vin,
                                    :price => @payment_info.amount,
                                    :currency => "USD",
                                    :quantity => 1 }]},
                    :amount => {
                      :total => @payment_info.amount,
                      :currency => "USD" },
                      :description => "This is the payment transaction description." }]})

          Rails.logger.debug "PaymentInfo>>>make_payment>> #{@payment.inspect}"

        # Create Payment and return the status(true or false)
        if @payment.create
          Rails.logger.debug "PaymentInfo>>payment.create success : #{@payment.inspect}"
          # @payment.id     # Payment Id
          credit_card = @payment.payer.funding_instruments.first.credit_card

          Rails.logger.debug "PaymentInfo>> Creating Transaction..."
          # TODO: Need to handle proper error handling on this path.
          @transaction = @policy.paypal_transactions.create!(
            { :pp_id=> @payment.id,
              :amount =>@payment.transactions.first.amount.total,
              :approved => @payment.state == 'approved' ? true : false,
              :address => credit_card.billing_address.line1,
              :city=>credit_card.billing_address.city,
              :state=>credit_card.billing_address.state,
              :zip_code=>credit_card.billing_address.postal_code,
              :card_number=>credit_card.number,
              :exp=>"#{credit_card.expire_month} / #{credit_card.expire_year}",
              :first_name=>credit_card.first_name,
              :last_name=>credit_card.last_name,
              :card_type=>credit_card.type,
              ## Need to think about how to display status for agent.
              :status=> @payment.state == 'approved' ? PaypalTransaction::ACTIVE : PaypalTransaction::PENDING
              })

          if @transaction.status == PaypalTransaction::ACTIVE
            @vehicle.update!(:start_date=>Date.today,
              :expr_date=>Date.today + 1.year )
           end

           Rails.logger.debug "PaymentInfo >> Transaction created...."
           @transaction
       else
          Rails.logger.debug "PaymentInfo>>payment.create failure : #{@payment.error}"
          @payment.error  # Error Hash
        end

    end

end
