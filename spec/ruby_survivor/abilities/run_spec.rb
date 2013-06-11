require 'spec_helper'

describe RubySurvivor::Abilities::Run do
  before(:each) do
    @space = stub(:empty? => true, :unit => nil)
    @position = stub(:relative_space => @space, :move => nil)
    @walk = RubySurvivor::Abilities::Run.new(stub(:position => @position, :say => nil))
  end
  
  it "should move position forward two spaces when calling perform" do
    pending
    # @position.expects(:move).with(1, 0)
    # @walk.perform
  end
  
  it "should move position right two spaces if that is direction" do
    pending
    # @position.expects(:move).with(0, 1)
    # @walk.perform(:right)
  end
  
  it "should keep position if something is in the way" do
    pending
    # @position.stubs(:move).raises("shouldn't be called")
    # @space.stubs(:empty?).returns(false)
    # lambda { @walk.perform(:right) }.should_not raise_error
  end

  it "should only move one space if second space is blocked" do
    pending
  end
end
