#spec/models/policy_spec

require 'spec_helper'

describe Policy do
    it "has a valid factory" do
        FactoryGirl.build(:policy).should be_valid
    end

    it "is invalid without a first name" do
        FactoryGirl.build(:policy, :first_name=>nil).should_not be_valid
    end

    it "is invalid without a last name" do
        FactoryGirl.build(:policy, :last_name=>nil).should_not be_valid
    end

    it "is invalid without an address" do
        FactoryGirl.build(:policy, :address=>nil).should_not be_valid
    end

    it "is invalid without a city" do
        FactoryGirl.build(:policy, :city=>nil).should_not be_valid
    end

    it "is invalid without a state" do
        FactoryGirl.build(:policy, :state=>nil).should_not be_valid
    end

    it "is invalid without a zipcode" do
        FactoryGirl.build(:policy, :zip_code=>nil).should_not be_valid
    end

    it "is invalid wihtout a number" do
        FactoryGirl.build(:policy, :number=>nil).should_not be_valid
    end

end
