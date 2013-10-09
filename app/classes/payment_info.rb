class PaymentInfo
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :first_name, :last_name, :address,
    :city, :zip_code, :card_number, :cvv2, :card_type, :amount, :state, :exp

    validates_presence_of :first_name
    validates_presence_of :last_name
    validates_presence_of :address
    validates_presence_of :city
    validates_presence_of :state
    validates_presence_of :zip_code
    validates_presence_of :card_number
    validates_presence_of :cvv2
    validates_presence_of :card_type
    validates_presence_of :amount


    def initialize(hash={})
        hash.each do |k,v|
            self.send "#{k}=", v
        end
    end

    def persisted?
        false
    end

end
