require 'spec_helper'

describe RubySurvivor::Game do
  before(:each) do
    @game = RubySurvivor::Game.new
  end
  
  # GAME DIR
  
  it "should make game directory if player says so" do
    RubySurvivor::UI.stubs(:ask).returns(true)
    Dir.expects(:mkdir).with('./rubysurvivor')
    @game.make_game_directory
  end
  
  it "should not make game and exit if player says no" do
    RubySurvivor::UI.stubs(:ask).returns(false)
    Dir.stubs(:mkdir).raises('should not be called')
    lambda { @game.make_game_directory }.should raise_error(SystemExit)
  end
  
  
  # PROFILES
  
  it "should load profiles for each profile path" do
    RubySurvivor::Profile.expects(:load).with('foo/.profile').returns(1)
    RubySurvivor::Profile.expects(:load).with('bar/.profile').returns(2)
    @game.stubs(:profile_paths).returns(['foo/.profile', 'bar/.profile'])
    @game.profiles.should == [1, 2]
  end
  
  it "should find profile paths using Dir[] search" do
    Dir.expects(:[]).with("./rubysurvivor/**/.profile")
    @game.profile_paths
  end
  
  it "should try to create profile when no profile paths are specified" do
    @game.stubs(:profiles).returns([])
    @game.expects(:new_profile).returns('profile')
    @game.profile.should == 'profile'
  end
  
  it "should ask a player to choose a profile if multiple profiles are available, but only once" do
    RubySurvivor::UI.expects(:choose).with('profile', [:profile1, [:new, 'New Profile']]).returns(:profile1)
    @game.stubs(:profiles).returns([:profile1])
    2.times { @game.profile.should == :profile1 }
  end
  
  it "should ask user to choose an area when creating a new profile" do
    RubySurvivor::UI.stubs(:gets).returns('')
    @game.stubs(:areas).returns([:area1, :area2])
    RubySurvivor::UI.expects(:choose).with('area', [:area1, :area2]).returns(stub(:path => '/foo/bar'))
    @game.new_profile
  end
  
  it "should pass name and selected area to profile" do
    profile = stub
    RubySurvivor::UI.stubs(:choose).returns(stub(:path => 'area_path'))
    RubySurvivor::UI.stubs(:request).returns('name')
    RubySurvivor::Profile.expects(:new).returns(profile)
    profile.expects(:area_path=).with('area_path')
    profile.expects(:survivor_name=).with('name')
    @game.new_profile.should == profile
  end
  
  
  # TOWERS
  
  it "load areas for each area path" do
    RubySurvivor::Area.expects(:new).with('areas/foo').returns(1)
    RubySurvivor::Area.expects(:new).with('areas/bar').returns(2)
    @game.stubs(:area_paths).returns(['areas/foo', 'areas/bar'])
    @game.areas.should == [1, 2]
  end
  
  it "should find area paths using Dir[] search" do
    Dir.expects(:[]).with(File.expand_path('../../../areas/*', __FILE__))
    @game.area_paths
  end
  
  
  # LEVEL
  
  it "should fetch current level from profile and cache it" do
    @game.stubs(:profile).returns(stub)
    @game.profile.expects(:current_level).returns('foo')
    2.times { @game.current_level.should == 'foo' }
  end
  
  it "should fetch next level from profile and cache it" do
    @game.stubs(:profile).returns(stub)
    @game.profile.expects(:next_level).returns('bar')
    2.times { @game.next_level.should == 'bar' }
  end
  
  it "should report final grade" do
    profile = RubySurvivor::Profile.new
    profile.current_epic_grades = { 1 => 0.7, 2 => 0.9 }
    @game.stubs(:profile).returns(profile)
    report = @game.final_report
    report.should include("Your average grade for this area is: B")
    report.should include("Level 1: C\n  Level 2: A")
  end
  
  it "should have an empty final report if no epic grades are available" do
    profile = RubySurvivor::Profile.new
    profile.current_epic_grades = {}
    @game.stubs(:profile).returns(profile)
    @game.final_report.should be_nil
  end
  
  it "should have an empty final report if practice level" do
    RubySurvivor::Config.practice_level = 2
    profile = RubySurvivor::Profile.new
    profile.current_epic_grades = { 1 => 0.7, 2 => 0.9 }
    @game.stubs(:profile).returns(profile)
    @game.final_report.should be_nil
  end
end
