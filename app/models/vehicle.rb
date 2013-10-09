require 'paypal_transaction'

class Vehicle < ActiveRecord::Base
    validates :vin, :presence=>true
    validates :make, :presence=>true
    validates :model, :presence=>true
    validates :color, :presence=>true

    belongs_to :policy

    # Runs a Query to determine if the vehicle is currently covered.
    # Basically returns true if the end_date is before Date.today. If
    # end_date is nil then by default the vehicle is not covered.
    def covered?
        unless end_date.nil?
            return (end_date<=>Date.today > 0 ) ? true : false
        end
        false
    end

    # TODO: Again Big hack need to figure out how to keep track
    # of vehicle converage duration.
    # def dates
    #     s_date = nil
    #     e_date = nil
    #     paypal_transactions.each do |t|
    #         if t.status == PaypalTransaction::ACTIVE
    #             s_date = t.created_at
    #             e_date = t.created_at + 1.year
    #             break
    #         end
    #      end
    #      return {:begin=>s_date, :end=>e_date}
    #     end
end
