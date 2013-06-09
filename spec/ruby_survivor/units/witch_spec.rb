require 'spec_helper'

describe RubySurvivor::Units::Witch do
  before(:each) do
    @witch = RubySurvivor::Units::Witch.new
  end
  
  it "should have look and shoot abilities" do
    @witch.abilities.keys.to_set.should == [:shoot!, :look].to_set
  end
  
  it "should have shoot power of 11" do
    @witch.shoot_power.should == 11
  end
  
  it "should have 3 max health" do
    @witch.max_health.should == 3
  end
  
  it "should appear as w on map" do
    @witch.character.should == "w"
  end
end
