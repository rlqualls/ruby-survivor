require 'spec_helper'

describe RubySurvivor::Tower do
  before(:each) do
    @tower = RubySurvivor::Tower.new('path/to/tower')
  end
  
  it "should consider last part of path as name" do
    @tower.name.should == 'tower'
  end
  
  it "should use name when converting to string" do
    @tower.to_s.should == @tower.name
  end
end
