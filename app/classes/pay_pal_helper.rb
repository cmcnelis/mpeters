require 'paypal-sdk-rest'
require 'paypal_transaction'

class PayPalHelper
    include PayPal::SDK::REST

    def initialize(payment_info, policy)
        Rails.logger.debug "Creating PayPalHelper >> #{payment_info.inspect}"
        @payment_info = payment_info
        @policy = policy
    end

    # Main public entrance into the pay routines.
    # TODO: Think we want to throw an exception here rather
    # than have error hashes in return objects
    def make_payment

            @vehicles = @policy.not_covered
            if @vehicles.count > 0
              _make_payment
            else
              Rails.logger.debug "Nothing to do..account is up to date!"
            end
     end

     # Retrieves the error hash for the process if one exists.
     def error
        @payment.error
    end


     private
     # Bunch of helper methods that probably need to be factored out a
     # bit.


     # Helper Method to build up the transaction hash for the pay-pal payment.
     def _build_transactions

        # We need to itemize the transaction for further record keeping possibly.
        # This could be rolled up into one transaction item, but figured the information
        # may come in useful later on.
        items = Array.new()

        @vehicles.each do |v|
          items << Item.new(:name => 'Deductible Coverage',
                      :sku => v.vin,
                      :price=> '%.2f' % v.cost,
                      :currency=>"USD",
                      :quantity=>1)
          Rails.logger.debug "PaypalHelper::_build_transactions::items   #{items.inspect}"
        end

        @transactions = Array.new
        @transactions[0] =
          Transaction.new(:item_list=>ItemList.new(:items=>items),
                              :amount=>{
                                :total=>'%.2f' % @payment_info.amount,
                                :currency=>"USD"
                              },
                              :description=>'Deductible Saver Coverage Payment.')
      end

      # Builds up the vehicle information hash for the transaction record.
      def _build_vehicle_info
        vins = Array.new
        makes = Array.new
        models = Array.new
        years = Array.new

        @vehicles.each do |v|
          vins << v.vin
          makes << v.make
          models << v.model
          years << v.year
        end

        hash = {
          :vins=>vins,
          :makes=>makes,
          :models=>models,
          :years=>years
        }
      end

      def _build_paypal_transaction
         # TODO: Need to handle proper error handling on this path.
          @transaction = @policy.paypal_transactions.create!(
            { :pp_id=> @payment.id,
              :amount =>@paymet_info.amount,
              :approved => @payment.state == 'approved' ? true : false,
              :address => @payment_info.address,
              :city=>@payment_info.city,
              :state=>@payment_info.state,
              :zip_code=>@payment_info.zip_code,
              :card_number=>credit_card.number,
              :expr_month =>@payment_info.expr_month,
              :expr_year =>@payment_info.expr_year,
              :first_name=>@payment_info.first_name,
              :last_name=>@payment_info.last_name,
              :card_type=>@payment_info.card_type,
              :vehicle_info=>_build_vehicle_info,
              ## Need to think about how to display status for agent.
              :status=> @payment.state == 'approved' ? PaypalTransaction::ACTIVE : PaypalTransaction::PENDING
              })
      end

      def _build_payment

        _build_transactions

        @payment = Payment.new({
                :intent => "sale",
                :transactions => @transactions,
                :payer => {
                    :payment_method => "credit_card",
                    :funding_instruments => [
                      { :credit_card => {
                          :type => @payment_info.card_type,
                          :number => @payment_info.card_number,
                          :expire_month => @payment_info.expr_month,
                          :expire_year => @payment_info.expr_year,
                          :cvv2 => @payment_info.cvv2,
                          :first_name => @payment_info.first_name,
                          :last_name => @payment_info.last_name,
                          :billing_address => {
                            :line1 => @payment_info.address,
                            :city => @payment_info.city,
                            :state => @payment_info.state,
                            :postal_code => @payment_info.zip_code,
                            :country_code => "US"
                          }
                        }
                      }
                    ]
                }
            })
      end

     def _make_payment

            _build_payment

          Rails.logger.debug "PaymentInfo>>>make_payment>> #{@payment.inspect}"

        # Create Payment and return the status(true or false
        if @payment.create
            Rails.logger.debug "PaymentInfo>>payment.create success : #{@payment.inspect}"
            # @payment.id     # Payment Id
            credit_card = @payment.payer.funding_instruments.first.credit_card

            Rails.logger.debug "PaymentInfo>> Creating Transaction..."

            # Record the payment for our local copy.
            _build_paypal_transaction

              if @transaction.status == PaypalTransaction::ACTIVE
                  @vehicles.each do |v|
                      v.update!(:start_date=>Date.today,
                        :expr_date=>Date.today + 1.year )
                  end
              end

             Rails.logger.debug "PaymentInfo >> Transaction created...."
             true
          else
              Rails.logger.debug "PaymentInfo>>payment.create failure : #{@payment.error}"
              false
          end

    end # _make_payment

end
