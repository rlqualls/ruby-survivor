require 'spec_helper'

describe RubySurvivor::Units::Captive do
  before(:each) do
    @captive = RubySurvivor::Units::Captive.new
  end
  
  it "should have 1 max health" do
    @captive.max_health.should == 1
  end
  
  it "should appear as C on map" do
    @captive.character.should == "C"
  end
  
  it "should be bound by default" do
    @captive.should be_bound
  end
  
  it "should not have explode ability by default (this should be added when needed)" do
    @captive.abilities.should_not include(:explode!)
  end
end
