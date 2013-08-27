class Vehicle < ActiveRecord::Base
    validates :vin, :presence=>true
    validates :start_date, :presence=>true
    validates :expr_date, :presence=>true
    validates :make, :presence=>true
    validates :model, :presence=>true
    validates :color, :presence=>true
    validates :deductible, :presence=>true

    belongs_to :policy
    has_many :drivers, dependent: :destroy

end
