require 'spec_helper'

describe RubySurvivor::Units::Spitter do
  before(:each) do
    @spitter = RubySurvivor::Units::Spitter.new
  end
  
  it "should have look and shoot abilities" do
    @spitter.abilities.keys.to_set.should == [:shoot!, :look].to_set
  end
  
  it "should have shoot power of 3" do
    @spitter.shoot_power.should == 3
  end
  
  it "should have 7 max health" do
    @spitter.max_health.should == 7
  end
  
  it "should appear as a on map" do
    @spitter.character.should == "a"
  end
end
