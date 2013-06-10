require 'spec_helper'

describe RubySurvivor::Abilities::Shoot do
  before(:each) do
    @shooter = stub(:position => stub, :shoot_power => 2, :say => nil)
    @shoot = RubySurvivor::Abilities::Shoot.new(@shooter)
  end
  
  it "should shoot only first unit" do
    receiver = stub(:alive? => true)
    receiver.expects(:take_damage).with(2)
    other = stub(:alive? => true)
    other.expects(:take_damage).never
    @shooter.expects(:has?).with(:shotgun).returns(true)
    @shoot.expects(:multi_unit).with(:forward, anything).returns([nil, receiver, other, nil])
    @shoot.perform
  end
  
  it "should shoot and do nothing if no units in the way" do
    @shooter.expects(:has?).with(:shotgun).returns(true)
    @shoot.expects(:multi_unit).with(:forward, anything).returns([nil, nil])
    lambda { @shoot.perform }.should_not raise_error
  end

  it "should not shoot if it doesn't have a gun" do
    @shooter.expects(:has?).with(:shotgun).returns(false)
    @shooter.expects(:say).with("wants to shoot but does not have anything to shoot with")
    @shoot.perform
  end
end
