require 'spec_helper'

describe RubySurvivor::Abilities::Pivot do
  before(:each) do
    @position = stub
    @pivot = RubySurvivor::Abilities::Pivot.new(stub(:position => @position, :say => nil))
  end
  
  it "should flip around when not passing arguments" do
    @position.expects(:rotate).with(2)
    @pivot.perform
  end
  
  it "should rotate 1 when pivoting right" do
    @position.expects(:rotate).with(1)
    @pivot.perform(:right)
  end
end
