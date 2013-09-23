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
    accepts_nested_attributes_for :vehicles, reject_if: lambda {
        |attributes| attributes['vin'].blank? or
        attributes['make'].blank? or
        attributes['model'].blank? or
        attributes['color'].blank? or
        attributes['deductible'].blank?
    }
end
