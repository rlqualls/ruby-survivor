require 'spec_helper'

describe RubySurvivor::Abilities::Rest do
  before(:each) do
    @survivor = RubySurvivor::Units::Survivor.new
    @rest = RubySurvivor::Abilities::Rest.new(@survivor)
  end
  
  it "should give 10% health back" do
    @survivor.stubs(:max_health).returns(20)
    @survivor.health = 10
    @rest.perform
    @survivor.health.should == 12
  end
  
  it "should add health when at max" do
    @survivor.stubs(:max_health).returns(20)
    @survivor.health = 20
    @rest.perform
    @survivor.health.should == 20
  end
  
  it "should not go over max health" do
    @survivor.stubs(:max_health).returns(20)
    @survivor.health = 19
    @rest.perform
    @survivor.health.should == 20
  end
end
