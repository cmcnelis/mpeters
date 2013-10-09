require 'paypal_transaction'

class Vehicle < ActiveRecord::Base
    validates :vin, :presence=>true
    validates :make, :presence=>true
    validates :model, :presence=>true
    validates :color, :presence=>true
    validates :year, :presence=>true

    belongs_to :policy

    # Returns true if the end_date is after Date.today else false if
    # end_date is nil or before Date.today.
    def covered?
        unless expr_date.nil?
            return (expr_date<=>Date.today > 0 ) ? true : false
        end
        false
    end
end
