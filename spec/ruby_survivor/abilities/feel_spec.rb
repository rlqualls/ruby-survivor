require 'spec_helper'

describe RubySurvivor::Abilities::Feel do
  before(:each) do
    @unit = stub(:position => stub, :say => nil)
    @feel = RubySurvivor::Abilities::Feel.new(@unit)
  end
  
  it "should get object at position from offset" do
    @unit.position.expects(:relative_space).with(1, 0)
    @feel.perform(:forward)
  end
end
