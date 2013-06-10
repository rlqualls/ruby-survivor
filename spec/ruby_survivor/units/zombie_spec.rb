require 'spec_helper'

describe RubySurvivor::Units::Zombie do
  before(:each) do
    @zombie = RubySurvivor::Units::Zombie.new
  end
  
  it "should have zombie abilities" do
    @zombie.abilities.keys.to_set.should == [:attack!, :feel, :walk!, :listen, :direction_of].to_set
  end
  
  it "should have attack power of 3" do
    @zombie.attack_power.should == 3
  end
  
  it "should have 12 max health" do
    @zombie.max_health.should == 12
  end
  
  it "should appear as z on map" do
    @zombie.character.should == "z"
  end

  it "should walk toward any survivors" do
    pending
  end
end
