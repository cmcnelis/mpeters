require 'paypal-sdk-rest'

class PayPalHelper
    include PayPal::SDK::REST

    def initialize(options)
        Rails.logger.debug "Creating PayPalHelper >> #{options.inspect}"
        @options = options
    end

    def make_payment

            # PayPal::SDK::REST.set_config(
            #         :mode => "sandbox", # "sandbox" or "live"
            #         :client_id => "AaYcMRA8wLvlRTZswDCgn7auLUKW5aMQ-FI05NdvvqLqeFpY_78vInumPpTl",
            #         :client_secret => "EAnS5hBHkx936SuC0GEcxGWVwBsp6QFzWJsuFGRoox1F_2jQ_8ceH_467ul1")

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
                                    :name => "item",
                                    :sku => "item",
                                    :price => "1",
                                    :currency => "USD",
                                    :quantity => 1 }]},
                    :amount => {
                      :total => "1.00",
                      :currency => "USD" },
                      :description => "This is the payment transaction description." }]})

        # Create Payment and return the status(true or false)
        if @payment.create
          @payment.id     # Payment Id
        else
          @payment.error  # Error Hash
        end
    end

end
