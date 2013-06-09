require 'spec_helper'

describe RubySurvivor::Abilities::Explode do
  before(:each) do
    @floor = RubySurvivor::Floor.new
    @floor.width = 2
    @floor.height = 3
    @captive = RubySurvivor::Units::Captive.new
    @floor.add(@captive, 0, 0)
    @explode = RubySurvivor::Abilities::Explode.new(@captive)
  end
  
  it "should subtract 100 health from each unit on the floor" do
    unit = RubySurvivor::Units::Base.new
    unit.health = 20
    @floor.add(unit, 0, 1)
    @captive.health = 10
    @explode.perform
    @captive.health.should == -90
    unit.health.should == -80
  end
  
  it "should explode when bomb time reaches zero" do
    @captive.health = 10
    @explode.time = 3
    @explode.pass_turn
    @explode.pass_turn
    @captive.health.should == 10
    @explode.pass_turn
    @captive.health.should == -90
  end
end
