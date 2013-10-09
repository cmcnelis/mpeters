require 'paypal_transaction'

class Vehicle < ActiveRecord::Base
    validates :vin, :presence=>true
    validates :make, :presence=>true
    validates :model, :presence=>true
    validates :color, :presence=>true

    belongs_to :policy
    has_many :paypal_transactions

    # TODO: Big Hack, need to clean the logic for keeping
    # track of a vehicle's coverage status
    def is_covered
        covered = false
        paypal_transactions.each do |t|
            if t.status == PaypalTransaction::ACTIVE
                covered = true
                break
            end
        end
        return covered
    end

    # TODO: Again Big hack need to figure out how to keep track
    # of vehicle converage duration.
    def dates
        s_date = nil
        e_date = nil
        paypal_transactions.each do |t|
            if t.status == PaypalTransaction::ACTIVE
                s_date = t.created_at
                e_date = t.created_at + 1.year
                break
            end
         end
         return {:begin=>s_date, :end=>e_date}
        end
end
