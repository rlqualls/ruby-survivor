require 'spec_helper'

describe RubySurvivor::Abilities::Health do
  before(:each) do
    @survivor = RubySurvivor::Units::Survivor.new
    @health = RubySurvivor::Abilities::Health.new(@survivor)
  end
  
  it "should return the amount of health" do
    @survivor.health = 10
    @health.perform.should == 10
  end
end
