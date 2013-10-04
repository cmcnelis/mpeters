class Agent < ActiveRecord::Base

    acts_as_authentic do |c|
        c.logged_in_timeout = 10.minutes
    end

    validates :first_name, :presence=>true
    validates :last_name, :presence=>true
    validates :email, :presence=>true, :uniqueness=>true, :confirmation=>true
    validates :company, :presence=>true

    validates_format_of :email, :with => Authlogic::Regex.email

    has_many :policies,  dependent: :destroy

    def name
        [first_name, last_name].join " "
    end

end
