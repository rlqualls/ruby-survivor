require 'spec_helper'

describe RubySurvivor::Units::ThickZombie do
  before(:each) do
    @zombie = RubySurvivor::Units::ThickZombie.new
  end
  
  it "should have 24 max health" do
    @zombie.max_health.should == 24
  end
  
  it "should appear as Z on map" do
    @zombie.character.should == "Z"
  end
  
  it "should have the name of 'Thick Zombie'" do
    @zombie.name.should == "Thick Zombie"
  end
end
