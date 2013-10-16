
class Policy < ActiveRecord::Base

    validates :first_name,  :presence=>true
    validates :last_name, :presence=>true
    validates :address, :presence=>true
    validates :city, :presence=>true
    validates :state, :presence=>true
    validates :zip_code, :presence=>true
    validates :number, :presence=>true, :uniqueness=>true
    validates :email, :presence=>true, :confirmation=>true
    validates :email_confirmation, :presence=>true



    belongs_to :agent
    has_many :vehicles, dependent: :destroy
    has_many :paypal_transactions

    accepts_nested_attributes_for :vehicles, :reject_if=> proc {
     |attributes| attributes['vin'].blank? and
            attributes['make'].blank? and
            attributes['model'].blank? and
            attributes['color'].blank?  and
            attributes['deductible'].blank? and
            attributes['drivers'].blank?
        }

    validates_associated :vehicles

    #Returns true if all the vehicles within the policy are currently covered,
    #else returns false
    def up_to_date?
        return not_covered.count > 0 ? false : true
    end

    # Returns of a list of vehicles within the policy that
    # have expired coverage.
    def not_covered
        items = Array.new

        vehicles.each do |v|
            unless v.covered?
                items << v
            end
        end

        items
    end

    # Calculates the total coverage cost outstanding for the policy.
    # Basically iterates over the non-covered vehicles and sums eache
    # individual vehicle coverage cost.
    def cost
        total = 0.0
        not_covered.each do |n|
            total += n.cost
        end
        total
    end
end
