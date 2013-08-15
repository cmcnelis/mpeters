#spec/models/agent_spec.rb

require 'spec_helper'

describe Agent do

    it "has a valid factory" do
        FactoryGirl.build(:agent).should be_valid
    end
    it "is invalid without a firstname" do
        FactoryGirl.build(:agent, :first_name=>nil).should_not be_valid
    end

    it "is invalid without a lastname" do
        FactoryGirl.build(:agent, :last_name=>nil).should_not be_valid
    end

    it "is invalid without an email" do
        FactoryGirl.build(:agent, :email=>nil).should_not be_valid
    end

    it "is invalid without a company" do
        FactoryGirl.build(:agent, :company=>nil).should_not be_valid
    end

    it "returns name as a string" do
        agent = FactoryGirl.build(:agent, :first_name=>"John", :last_name=>"Doe")
        agent.name.should == "John Doe"
    end

end
