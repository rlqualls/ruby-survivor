require 'spec_helper'

describe RubySurvivor::Abilities::Heal do
  before(:each) do
    @survivor = RubySurvivor::Units::Survivor.new
    @heal = RubySurvivor::Abilities::Heal.new(@survivor)
    @survivor.give(:medpack)
  end
  
  it "should give 50% health back" do
    @survivor.stubs(:max_health).returns(20)
    @survivor.health = 5
    @heal.perform
    @survivor.health.should == 15
  end
  
  it "should add no health when at max" do
    @survivor.stubs(:max_health).returns(20)
    @survivor.health = 20
    @heal.perform
    @survivor.health.should == 20
  end
  
  it "should not go over max health" do
    @survivor.stubs(:max_health).returns(20)
    @survivor.health = 19
    @heal.perform
    @survivor.health.should == 20
  end
end
