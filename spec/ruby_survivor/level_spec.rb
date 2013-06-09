require 'spec_helper'
require 'set'

describe RubySurvivor::Level do
  before(:each) do
    @profile = RubySurvivor::Profile.new
    @floor = RubySurvivor::Floor.new
    @level = RubySurvivor::Level.new(@profile, 1)
    @level.floor = @floor
    @level.stubs(:failed?).returns(false)
  end
  
  it "should consider passed when survivor is at the exit" do
    @level.survivor = RubySurvivor::Units::Survivor.new
    @floor.add(@level.survivor, 0, 0, :north)
    @floor.place_exit(0, 0)
    @level.should be_passed
  end
  
  it "should default time bonus to zero" do
    @level.time_bonus.should be_zero
  end
  
  it "should have a grade relative to ace score" do
    @level.ace_score = 100
    @level.grade_for(110).should == "S"
    @level.grade_for(100).should == "S"
    @level.grade_for(99).should == "A"
    @level.grade_for(89).should == "B"
    @level.grade_for(79).should == "C"
    @level.grade_for(69).should == "D"
    @level.grade_for(59).should == "F"
  end
  
  it "should have no grade if there is no ace score" do
    @level.ace_score.should be_nil
    @level.grade_for(100).should be_nil
  end
  
  it "should load file contents into level" do
    @level.stubs(:load_path).returns('path/to/level.rb')
    File.expects(:read).with('path/to/level.rb').returns("description 'foo'")
    @level.load_level
    @level.description.should == 'foo'
  end
  
  it "should have a player path from profile" do
    @profile.stubs(:player_path).returns('path/to/player')
    @level.player_path.should == 'path/to/player'
  end
  
  it "should have a load path from profile tower with level number in it" do
    @profile.stubs(:tower_path).returns('path/to/tower')
    @level.load_path.should == File.expand_path('towers/tower/level_001.rb')
  end
  
  it "should exist if file exists" do
    @level.stubs(:load_path).returns('/foo/bar')
    File.expects(:exist?).with('/foo/bar').returns(true)
    @level.exists?.should be_true
  end
  
  it "should load player and player path" do
    @level.stubs(:player_path).returns('player/path')
    $:.expects(:<<).with('player/path')
    @level.expects(:load).with('player.rb')
    @level.load_player
  end
  
  it "should generate player files" do
    @level.expects(:load_level)
    generator = stub
    generator.expects(:generate)
    RubySurvivor::PlayerGenerator.expects(:new).with(@level).returns(generator)
    @level.generate_player_files
  end
  
  it "should setup survivor with profile abilities" do
    @profile.abilities = [:foo, :bar]
    survivor = stub_everything
    survivor.expects(:add_abilities).with(:foo, :bar)
    @level.setup_survivor(survivor)
  end
  
  it "should setup survivor with profile name" do
    @profile.survivor_name = "Joe"
    survivor = stub_everything
    survivor.expects(:name=).with("Joe")
    @level.setup_survivor(survivor)
  end
  
  describe "playing" do
    before(:each) do
      @level.stubs(:load_level)
    end
    
    it "should load level once when playing multiple turns" do
      @level.expects(:load_level)
      @level.play(2)
    end
    
    it "should call prepare_turn and play_turn on each object specified number of times" do
      object = RubySurvivor::Units::Base.new
      object.expects(:prepare_turn).times(2)
      object.expects(:perform_turn).times(2)
      @floor.add(object, 0, 0, :north)
      @level.play(2)
    end
  
    it "should return immediately when passed" do
      object = RubySurvivor::Units::Base.new
      object.expects(:turn).times(0)
      @floor.add(object, 0, 0, :north)
      @level.stubs(:passed?).returns(true)
      @level.play(2)
    end
  
    it "should yield to block in play method for each turn" do
      int = 0
      @level.play(2) do
        int += 1
      end
      int.should == 2
    end
  
    it "should count down time_bonus once each turn" do
      @level.time_bonus = 10
      @level.play(3)
      @level.time_bonus.should == 7
    end
  
    it "should count down time_bonus below 0" do
      @level.time_bonus = 2
      @level.play(5)
      @level.time_bonus.should be_zero
    end
    
    it "should have a pretty score calculation" do
      @level.score_calculation(123, 45).should == "123 + 45 = 168"
    end
    
    it "should not have a score calculation when starting score is zero" do
      @level.score_calculation(0, 45).should == "45"
    end
  end
  
  describe "tallying points" do
    before(:each) do
      @survivor = stub(:score => 0, :abilities => {})
      @level.stubs(:survivor).returns(@survivor)
      @level.floor.stubs(:other_units).returns([stub])
    end
    
    it "should add survivor score to profile" do
      @survivor.stubs(:score).returns(30)
      @level.tally_points
      @profile.score.should == 30
    end
    
    it "should add survivor score to profile for epic mode" do
      @profile.enable_epic_mode
      @survivor.stubs(:score).returns(30)
      @level.tally_points
      @profile.current_epic_score.should == 30
    end
    
    it "should add level grade percent to profile for epic mode" do
      @level.ace_score = 100
      @profile.enable_epic_mode
      @survivor.stubs(:score).returns(30)
      @level.tally_points
      @profile.current_epic_grades.should == { 1 => 0.3 }
    end
    
    it "should not add level grade if ace score is not set" do
      @level.ace_score = nil
      @profile.enable_epic_mode
      @survivor.stubs(:score).returns(30)
      @level.tally_points
      @profile.current_epic_grades.should == {}
    end
    
    it "should apply survivor abilities to profile" do
      @survivor.stubs(:abilities).returns({:foo => nil, :bar => nil})
      @level.tally_points
      @profile.abilities.to_set.should == [:foo, :bar].to_set
    end
    
    it "should apply time bonus to profile score" do
      @level.time_bonus = 20
      @level.tally_points
      @profile.score.should == 20
    end
    
    it "should give 20% bonus when no other units left" do
      @level.floor.stubs(:other_units).returns([])
      @survivor.stubs(:score).returns(10)
      @level.time_bonus = 10
      @level.tally_points
      @profile.score.should == 24
    end
  end
end
