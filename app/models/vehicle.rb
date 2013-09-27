class Vehicle < ActiveRecord::Base
    validates :vin, :presence=>true
    validates :make, :presence=>true
    validates :model, :presence=>true
    validates :color, :presence=>true

    belongs_to :policy
    has_many :paypal_transactions

end
