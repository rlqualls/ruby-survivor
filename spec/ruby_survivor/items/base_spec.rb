require 'spec_helper'

describe RubySurvivor::Items::Base do
  before(:each) do
    @item = RubySurvivor::Items::Base.new
  end
   
  it "should have no type" do
    @item.type.should == :nothing
  end  

  it "should be able to be removed" do
    @item.position = [0, 0]
    @item.remove
    @item.position.should be_nil
  end
end
