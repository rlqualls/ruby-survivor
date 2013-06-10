require 'spec_helper'

describe RubySurvivor::Position do
  before(:each) do
    @entity = RubySurvivor::Entity.new
    @floor = RubySurvivor::Floor.new
    @floor.width = 6
    @floor.height = 5
    @floor.add(@entity, 1, 2, :north)
    @position = @entity.position
  end
  
  it "should rotate clockwise" do
    @position.direction.should == :north
    [:east, :south, :west, :north, :east].each do |dir|
      @position.rotate(1)
      @position.direction.should == dir
    end
  end
  
  it "should rotate counterclockwise" do
    @position.direction.should == :north
    [:west, :south, :east, :north, :west].each do |dir|
      @position.rotate(-1)
      @position.direction.should == dir
    end
  end
  
  it "should get relative space in front" do
    entity = RubySurvivor::Entity.new
    @floor.add(entity, 1, 1)
    @position.relative_space(1).should_not be_empty
  end
  
  it "should get relative object in front when rotated" do
    entity = RubySurvivor::Entity.new
    @floor.add(entity, 2, 2)
    @position.rotate(1)
    @position.relative_space(1).should_not be_empty
  end
  
  it "should get relative object diagonally" do
    entity = RubySurvivor::Entity.new
    @floor.add(entity, 0, 1)
    @position.relative_space(1, -1).should_not be_empty
  end
  
  it "should get relative object diagonally when rotating" do
    entity = RubySurvivor::Entity.new
    @floor.add(entity, 0, 1)
    @position.rotate(2)
    @position.relative_space(-1, 1).should_not be_empty
  end
  
  it "should move object on floor relatively" do
    @floor.get(1, 2).should == @entity
    @position.move(-1, 2)
    @floor.get(1, 2).should be_nil
    @floor.get(3, 3).should == @entity
    @position.rotate(1)
    @position.move(-1)
    @floor.get(3, 3).should be_nil
    @floor.get(2, 3).should == @entity
  end
  
  it "should return distance from exit as 0 when on exit" do
    @floor.place_exit(1, 2)
    @position.distance_from_exit.should == 0
  end
  
  it "should return distance from exit in both directions" do
    @floor.place_exit(0, 3)
    @position.distance_from_exit.should == 2
  end
  
  it "should return relative direction of exit" do
    @floor.place_exit(0, 0)
    @position.relative_direction_of_exit.should == :forward
  end
  
  it "should return relative direction of given space" do
    @position.relative_direction_of(@floor.space(5, 3)).should == :right
    @position.rotate 1
    @position.relative_direction_of(@floor.space(1, 4)).should == :right
  end
  
  it "should be able to determine relative direction" do
    @position.relative_direction(:north).should == :forward
    @position.relative_direction(:south).should == :backward
    @position.relative_direction(:west).should == :left
    @position.relative_direction(:east).should == :right
    @position.rotate 1
    @position.relative_direction(:north).should == :left
    @position.rotate 1
    @position.relative_direction(:north).should == :backward
    @position.rotate 1
    @position.relative_direction(:north).should == :right
  end
  
  it "should return a space at the same location as position" do
    @position.space.location.should == [1, 2]
  end
  
  it "should return distance of given space" do
    @position.distance_of(@floor.space(5, 3)).should == 5
    @position.distance_of(@floor.space(4, 2)).should == 3
  end
end
