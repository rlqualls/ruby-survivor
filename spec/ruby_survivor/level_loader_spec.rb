require 'spec_helper'

describe RubySurvivor::LevelLoader do
  describe "with profile" do
    before(:each) do
      @profile = RubySurvivor::Profile.new
      @level = RubySurvivor::Level.new(@profile, 1)
      @loader = RubySurvivor::LevelLoader.new(@level)
    end
    
    it "should be able to add description, tip and clue" do
      @loader.description "foo"
      @loader.tip "bar"
      @loader.clue "clue"
      @level.description.should == "foo"
      @level.tip.should == "bar"
      @level.clue.should == "clue"
    end
    
    it "should be able to set size" do
      @loader.size 5, 3
      @level.floor.width.should == 5
      @level.floor.height.should == 3
    end
    
    it "should be able to add exit" do
      @level.floor.expects(:place_exit).with(1, 2)
      @loader.exit 1, 2
    end

    it "should not exit the program/class upon calling exit" do
      @loader.exit 1, 2
      @loader.size 5, 3
      @level.floor.width.should == 5
    end
    
    it "should yield new unit when building" do
      @loader.unit :base, 1, 2 do |unit|
        unit.should be_kind_of(RubySurvivor::Units::Base)
        unit.position.should be_at(1, 2)
      end
    end
    
    it "should be able to add multi-word units" do
      lambda { @loader.unit :thick_zombie, 1, 2 }.should_not raise_error
    end
    
    it "should build survivor from profile" do
      @loader.survivor 1, 2 do |unit|
        unit.should be_kind_of(RubySurvivor::Units::Survivor)
        unit.position.should be_at(1, 2)
      end
    end
    
    it "should be able to set time bonus" do
      @loader.time_bonus 100
      @level.time_bonus.should == 100
    end
  end
end
