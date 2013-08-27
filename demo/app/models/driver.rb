class Driver < ActiveRecord::Base
    validates :first_name, :presence =>true
    validates :last_name, :presence => true

    belongs_to :vehicle

    def name
        [first_name, last_name].join " "
    end

end
