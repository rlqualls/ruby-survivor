require 'spec_helper'

describe RubySurvivor::Abilities::DirectionOfStairs do
  before(:each) do
    @position = stub
    @distance = RubySurvivor::Abilities::DirectionOfStairs.new(stub(:position => @position, :say => nil))
  end
  
  it "should return relative direction of stairs" do
    @position.stubs(:relative_direction_of_stairs).returns(:left)
    @distance.perform.should == :left
  end
end
