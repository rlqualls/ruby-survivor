require 'spec_helper'

class Player
  def turn(survivor)
  end
end

describe RubySurvivor::Units::Survivor do
  before(:each) do
    @survivor = RubySurvivor::Units::Survivor.new
  end
  
  it "should default name to survivor" do
    @survivor.name.should == "Survivor"
    @survivor.name = ''
    @survivor.name.should == "Survivor"
  end
  
  it "should be able to set name" do
    @survivor.name = "Joe"
    @survivor.name.should == "Joe"
    @survivor.to_s.should == "Joe"
  end
  
  it "should have 20 max health" do
    @survivor.max_health.should == 20
  end
  
  it "should have 0 score at beginning and be able to earn points" do
    @survivor.score.should be_zero
    @survivor.earn_points(5)
    @survivor.score.should == 5
  end
  
  it "should call player.play_turn and pass turn to player" do
    player = stub
    player.expects(:play_turn).with('turn')
    @survivor.stubs(:player).returns(player)
    @survivor.play_turn('turn')
  end
  
  it "should call Player.new the first time loading player, and return same object next time" do
    Player.expects(:new).returns('player').times(1)
    2.times do
      @survivor.player.should == 'player'
    end
  end
  
  it "should have an attack power of 5" do
    @survivor.attack_power.should == 5
  end
  
  it "should have an shoot power of 3" do
    @survivor.shoot_power.should == 3
  end
  
  it "should appear as @ on map" do
    @survivor.character.should == "@"
  end  
end
