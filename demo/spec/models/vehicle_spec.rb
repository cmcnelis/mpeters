#spec/models/vehicle_spec

require 'spec_helper'

describe Vehicle do

    it "has a valid factory" do
        FactoryGirl.build(:vehicle).should be_valid
    end

    it "is invalid without a vin" do
        FactoryGirl.build(:vehicle, :vin=>nil).should_not be_valid
    end

    it "is invalid withou a make" do
        FactoryGirl.build(:vehicle, :make=>nil).should_not be_valid
    end

    it "is invalid without a model" do
        FactoryGirl.build(:vehicle, :model=>nil).should_not be_valid
    end

    it "is invalid without a color" do
        FactoryGirl.build(:vehicle, :color=>nil).should_not be_valid
    end

    it "is invalid without a start_date" do
        FactoryGirl.build(:vehicle, :start_date=>nil).should_not be_valid
    end

    it "is invalid without a expr_date" do
        FactoryGirl.build(:vehicle, :expr_date=>nil).should_not be_valid
    end
    it "is invalid without a deductible" do
        FactoryGirl.build(:vehicle, :deductible=>nil).should_not be_valid
    end

end
