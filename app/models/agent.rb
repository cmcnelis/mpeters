class Agent < ActiveRecord::Base

    acts_as_authentic

    validates :first_name, :presence=>true
    validates :last_name, :presence=>true
    validates :email, :presence=>true
    validates :company, :presence=>true

    has_many :policies,  dependent: :destroy

    def name
        [first_name, last_name].join " "
    end

end
