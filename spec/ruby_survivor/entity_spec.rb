require 'spec_helper'

describe RubySurvivor::Entity do
  before(:each) do
    @entity = RubySurvivor::Entity.new
  end
   
  it "should consider itself dead when no position" do
    @entity.position.should be_nil
    @entity.should_not be_alive
  end
  
  it "should consider itself alive with position" do
    @entity.position = stub
    @entity.should be_alive
  end
  
  it "should default max health to 10" do
    @entity.max_health.should be_zero
  end
   
  it "should default health to max health" do
    @entity.stubs(:max_health).returns(10)
    @entity.health.should == 10
  end
  
  it "should subtract health when taking damage" do
    @entity.stubs(:max_health).returns(10)
    @entity.take_damage(3)
    @entity.health.should == 7
  end
  
  it "should do nothing when taking damage if health isn't set" do
    lambda { @entity.take_damage(3) }.should_not raise_error
  end
  
  it "should set position to nil when running out of health" do
    @entity.position = stub
    @entity.stubs(:max_health).returns(10)
    @entity.take_damage(10)
    @entity.position.should be_nil
  end
  
  it "should print out line with name when speaking" do
    RubySurvivor::UI.expects(:puts_with_delay).with("Entity foo")
    @entity.say "foo"
  end
  
  it "should return name in to_s" do
    @entity.name.should == 'Entity'
    @entity.to_s.should == 'Entity'
  end
  
  it "should prepare turn by calling play_turn with next turn object" do
    @entity.stubs(:next_turn).returns('next_turn')
    @entity.expects(:play_turn).with('next_turn')
    @entity.prepare_turn
  end
  
  it "should perform action when calling perform on turn" do
    @entity.position = stub
    RubySurvivor::Abilities::Walk.any_instance.expects(:perform).with(:backward)
    @entity.add_abilities(:walk!)
    turn = stub(:action => [:walk!, :backward])
    @entity.stubs(:next_turn).returns(turn)
    @entity.prepare_turn
    @entity.perform_turn
  end
  
  it "should not perform action when dead (no position)" do
    @entity.position = nil
    RubySurvivor::Abilities::Walk.any_instance.stubs(:perform).raises("action should not be called")
    @entity.add_abilities(:walk!)
    turn = stub(:action => [:walk!, :backward])
    @entity.stubs(:next_turn).returns(turn)
    @entity.prepare_turn
    @entity.perform_turn
  end
  
  it "should not raise an exception when calling perform_turn when there's no action" do
    @entity.prepare_turn
    lambda { @entity.perform_turn }.should_not raise_error
  end
  
  it "should pass abilities to new turn when calling next_turn" do
    RubySurvivor::Turn.expects(:new).with(:walk! => nil, :attack! => nil, :feel => nil).returns('turn')
    @entity.stubs(:abilities).returns(:walk! => nil, :attack! => nil, :feel => nil)
    @entity.next_turn.should == 'turn'
  end
  
  it "should add ability" do
    RubySurvivor::Abilities::Walk.expects(:new).with(@entity).returns('walk')
    @entity.add_abilities(:walk!)
    @entity.abilities.should == { :walk! => 'walk' }
  end
  
  it "should appear as question mark on map" do
    @entity.character.should == "?"
  end  
end
