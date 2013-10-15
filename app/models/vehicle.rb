require 'paypal_transaction'

class Vehicle < ActiveRecord::Base

    # Flat percentage rate applied to deductible.
    # Not sure what we want for this value.
    RATE = 0.10

    validates :vin, :presence=>true
    validates :make, :presence=>true
    validates :model, :presence=>true
    validates :color, :presence=>true
    validates :year, :presence=>true
    validates :deductible, :presence=>true

    belongs_to :policy

    # Returns true if the end_date is after Date.today else false if
    # end_date is nil or before Date.today.
    def covered?
        unless expr_date.nil?
            return ((expr_date<=>Date.today )> 0 ) ? true : false
        end
        false
    end

    # Returns the cost of coverage for the vehicle
    def cost
        deductible * RATE
    end
end
