class Policy < ActiveRecord::Base
    validates :first_name,  :presence=>true
    validates :last_name, :presence=>true
    validates :address, :presence=>true
    validates :city, :presence=>true
    validates :state, :presence=>true
    validates :zip_code, :presence=>true
    validates :number, :presence=>true, :uniqueness=>true

    belongs_to :agent
    has_many :vehicles, dependent: :destroy
end
