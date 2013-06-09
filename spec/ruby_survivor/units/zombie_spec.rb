require 'spec_helper'

describe RubySurvivor::Units::Zombie do
  before(:each) do
    @zombie = RubySurvivor::Units::Zombie.new
  end
  
  it "should have attack action" do
    @zombie.abilities.keys.should include(:attack!)
  end
  
  it "should have feel sense" do
    @zombie.abilities.keys.should include(:feel)
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
end
