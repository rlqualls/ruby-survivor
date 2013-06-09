require 'spec_helper'

describe RubySurvivor::Abilities::Rescue do
  before(:each) do
    @survivor = RubySurvivor::Units::Survivor.new
    @rescue = RubySurvivor::Abilities::Rescue.new(@survivor)
  end
  
  it "should rescue captive" do
    captive = RubySurvivor::Units::Captive.new
    captive.position = stub
    @rescue.expects(:space).with(:forward).returns(stub(:captive? => true))
    @rescue.expects(:unit).with(:forward).returns(captive)
    @survivor.expects(:earn_points).with(20)
    @rescue.perform
    captive.position.should be_nil
  end
  
  it "should do nothing to other unit if not bound" do
    unit = RubySurvivor::Units::Base.new
    unit.position = stub
    @rescue.expects(:space).with(:forward).returns(stub(:captive? => false))
    @rescue.expects(:unit).with(:forward).never
    @survivor.expects(:earn_points).never
    @rescue.perform
    unit.position.should_not be_nil
  end
  
  it "should release other unit when bound" do
    unit = RubySurvivor::Units::Base.new
    unit.bind
    unit.position = stub
    @rescue.expects(:space).with(:forward).returns(stub(:captive? => true))
    @rescue.expects(:unit).with(:forward).returns(unit)
    @survivor.expects(:earn_points).never
    @rescue.perform
    unit.should_not be_bound
    unit.position.should_not be_nil
  end
end
