require 'spec_helper'

describe Driver do
    it "has a valid factory" do
        FactoryGirl.create(:driver).should be_valid
    end

    it "is invalid without a firstname" do
        FactoryGirl.build(:driver, first_name: nil).should_not be_valid
    end

    it "is invalid without a lastname" do
        FactoryGirl.build(:driver, last_name: nil).should_not be_valid
    end

    it "returns a contact's full name as a string" do
        driver = FactoryGirl.build(:driver, first_name: "John", last_name: "Doe")
        driver.name.should == "John Doe"
    end

end
