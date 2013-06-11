require 'spec_helper'

describe RubySurvivor::Abilities::Swing do
  before(:each) do
    @swinger = stub(:position => stub, :stamina => 20, :attack_power => 3, :say => nil)
    @swing = RubySurvivor::Abilities::Swing.new(@swinger)
  end
  
  it "should subtract swing power amount from health" do
    pending
    # receiver = RubySurvivor::Units::Base.new
    # receiver.stubs(:alive?).returns(true)
    # receiver.health = 5
    # @swing.stubs(:unit).returns(receiver)
    # @swing.perform
    # receiver.health.should == 2
  end
  
  it "should do nothing if recipient is nil" do
    @swing.stubs(:unit).returns(nil)
    lambda { @swing.perform }.should_not raise_error
  end
  
  it "should get object at position from offset" do
    @swinger.position.expects(:relative_space).with(1, 0)
    @swing.space(:forward)
  end

  it "should do more damage than attack_power" do
    # receiver = stub(:take_damage => nil, :max_health => 3, :alive? => false)
    # @swing.stubs(:unit).returns(receiver)
    # # @swing.expects(:damage).with(receiver, @swinger.attack_power * @swing.damage_multiplier)
    # @swing.perform
  end
  
  it "should award points when killing unit" do
    receiver = stub(:take_damage => nil, :max_health => 3, :alive? => false)
    @swing.stubs(:unit).returns(receiver)
    @swinger.expects(:lose_stamina)
    @swinger.expects(:earn_points).with(3)
    @swing.perform
  end
  
  it "should not award points when not killing unit" do
    receiver = stub(:max_health => 8, :alive? => true)
    receiver.expects(:take_damage)
    @swing.stubs(:unit).returns(receiver)
    @swinger.expects(:earn_points).never
    @swinger.expects(:lose_stamina)
    @swing.perform
  end
  
  it "should reduce swing power when attacking backward" do
    pending
    # receiver = RubySurvivor::Units::Base.new
    # receiver.stubs(:alive?).returns(true)
    # receiver.health = 5
    # @swing.stubs(:unit).returns(receiver)
    # @swing.perform(:backward)
    # receiver.health.should == 3
  end
end
