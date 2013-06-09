require 'spec_helper'

describe RubySurvivor::Floor do
  describe "2x3" do
    before(:each) do
      @floor = RubySurvivor::Floor.new
      @floor.width = 2
      @floor.height = 3
    end
  
    it "should be able to add a unit and fetch it at that position" do
      unit = RubySurvivor::Units::Base.new
      @floor.add(unit, 0, 1, :north)
      @floor.get(0, 1).should == unit
    end
  
    it "should not consider unit on floor if no position" do
      unit = RubySurvivor::Units::Base.new
      @floor.add(unit, 0, 1, :north)
      unit.position = nil
      @floor.units.should_not include(unit)
    end
  
    it "should fetch other units not survivor" do
      unit = RubySurvivor::Units::Base.new
      survivor = RubySurvivor::Units::Survivor.new
      @floor.add(unit, 0, 0, :north)
      @floor.add(survivor, 1, 0, :north)
      @floor.other_units.should_not include(survivor)
      @floor.other_units.should include(unit)
    end
  
    it "should not consider corners out of bounds" do
      @floor.should_not be_out_of_bounds(0, 0)
      @floor.should_not be_out_of_bounds(1, 0)
      @floor.should_not be_out_of_bounds(1, 2)
      @floor.should_not be_out_of_bounds(0, 2)
    end
  
    it "should consider out of bounds when going beyond sides" do
      @floor.should be_out_of_bounds(-1, 0)
      @floor.should be_out_of_bounds(0, -1)
      @floor.should be_out_of_bounds(0, 3)
      @floor.should be_out_of_bounds(2, 0)
    end
  
    it "should return space at the specified location" do
      @floor.space(0, 0).should be_kind_of(RubySurvivor::Space)
    end
  
    it "should place exit and be able to fetch the location" do
      @floor.place_exit(1, 2)
      @floor.exit_location.should == [1, 2]
    end
  end
  
  describe "3x1" do
    before(:each) do
      @floor = RubySurvivor::Floor.new
      @floor.width = 3
      @floor.height = 1
    end
  
    it "should print map with exit and unit" do
      @floor.add(RubySurvivor::Units::Survivor.new, 0, 0)
      @floor.place_exit(2, 0)
      @floor.character.should == <<-MAP
 ---
|@ >|
 ---
MAP
    end
    
    it "should return unique units" do
      u1 = RubySurvivor::Units::Base.new
      @floor.add(u1, 0, 0)
      @floor.add(RubySurvivor::Units::Base.new, 1, 0)
      @floor.unique_units.should == [u1]
    end
  end
end
