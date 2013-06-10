require 'spec_helper'

describe RubySurvivor::Area do
  before(:each) do
    @tower = RubySurvivor::Area.new('path/to/area')
  end
  
  it "should consider last part of path as name" do
    @tower.name.should == 'area'
  end
  
  it "should use name when converting to string" do
    @tower.to_s.should == @tower.name
  end
end
