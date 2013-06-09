require 'spec_helper'

describe RubySurvivor::Space do
  before(:each) do
    @floor = RubySurvivor::Floor.new
    @floor.width = 2
    @floor.height = 3
  end
  
  describe "with empty space" do
    before(:each) do
      @space = @floor.space(0, 0)
    end
    
    it "should not be enemy" do
      @space.should_not be_enemy
    end
    
    it "should not be survivor" do
      @space.should_not be_survivor
    end
    
    it "should be empty" do
      @space.should be_empty
    end

    it "should not be item" do
      @space.should_not be_item
    end 
    it "should not be wall" do
      @space.should_not be_wall
    end
    
    it "should not be stairs" do
      @space.should_not be_stairs
    end
    
    it "should not be captive" do
      @space.should_not be_captive
    end
    
    it "should say 'nothing' as name" do
      @space.to_s.should == 'nothing'
    end
    
    it "should not be ticking" do
      @space.should_not be_ticking
    end
  end
  
  describe "out of bounds" do
    before(:each) do
      @space = @floor.space(-1, 1)
    end
  
    it "should be wall" do
      @space.should be_wall
    end
  
    it "should not be empty" do
      @space.should_not be_empty
    end
    
    it "should have name of 'wall'" do
      @space.to_s.should == 'wall'
    end
  end
  
  describe "with survivor" do
    before(:each) do
      survivor = RubySurvivor::Units::Survivor.new
      @floor.add(survivor, 0, 0)
      @space = @floor.space(0, 0)
    end
    
    it "should be survivor" do
      @space.should be_survivor
    end
    
    it "should be player" do
      @space.should be_player
    end
    
    it "should not be enemy" do
      @space.should_not be_enemy
    end
    
    it "should not be empty" do
      @space.should_not be_empty
    end
    
    it "should know what thing is on that space" do
      @space.thing.should be_kind_of(RubySurvivor::Units::Survivor)
    end
  end
  
  describe "with enemy" do
    before(:each) do
      @floor.add(RubySurvivor::Units::Zombie.new, 0, 0)
      @space = @floor.space(0, 0)
    end
    
    it "should be enemy" do
      @space.should be_enemy
    end
    
    it "should not be survivor" do
      @space.should_not be_survivor
    end
    
    it "should not be empty" do
      @space.should_not be_empty
    end
    
    it "should have name of thing" do
      @space.to_s.should == "Zombie"
    end
    
    describe "bound" do
      before(:each) do
        @space.thing.bind
      end
      
      it "should be captive" do
        @space.should be_captive
      end
      
      it "should not look like enemy" do
        @space.should_not be_enemy
      end
    end
  end
  
  describe "with captive" do
    before(:each) do
      @captive = RubySurvivor::Units::Captive.new
      @floor.add(@captive, 0, 0)
      @space = @floor.space(0, 0)
    end
    
    it "should be captive" do
      @space.should be_captive
    end
    
    it "should not be enemy" do
      @space.should_not be_enemy
    end
    
    it "should be ticking if captive has time bomb" do
      @captive.add_abilities :explode!
      @space.should be_ticking
    end
    
    it "should not be ticking if captive does not have time bomb" do
      @space.should_not be_ticking
    end
  end
  
  describe "at stairs" do
    before(:each) do
      @floor.place_stairs(0, 0)
      @space = @floor.space(0, 0)
    end
    
    it "should be empty" do
      @space.should be_empty
    end
    
    it "should be stairs" do
      @space.should be_stairs
    end
  end
end
