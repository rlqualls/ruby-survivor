require 'spec_helper'

describe RubySurvivor::Floor do
  describe "2x3" do
    before(:each) do
      @floor = RubySurvivor::Floor.new
      @floor.width = 2
      @floor.height = 3
    end
  
    it "should be able to add a entity and fetch it at that position" do
      entity = RubySurvivor::Units::Base.new
      @floor.add(entity, 0, 1, :north)
      @floor.get(0, 1).should == entity
    end
  
    it "should not consider entity on floor if no position" do
      entity = RubySurvivor::Units::Base.new
      @floor.add(entity, 0, 1, :north)
      entity.position = nil
      @floor.entities.should_not include(entity)
    end
  
    it "should fetch other entities not survivor" do
      entity = RubySurvivor::Units::Base.new
      survivor = RubySurvivor::Units::Survivor.new
      @floor.add(entity, 0, 0, :north)
      @floor.add(survivor, 1, 0, :north)
      @floor.other_entities.should_not include(survivor)
      @floor.other_entities.should include(entity)
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
  
    it "should print map with exit and entity" do
      @floor.add(RubySurvivor::Units::Survivor.new, 0, 0)
      @floor.place_exit(2, 0)
      @floor.character.should == <<-MAP
 ---
|@ >|
 ---
MAP
    end
    
    it "should return unique entities" do
      u1 = RubySurvivor::Units::Base.new
      @floor.add(u1, 0, 0)
      @floor.add(RubySurvivor::Units::Base.new, 1, 0)
      @floor.unique_entities.should == [u1]
    end
  end
end
