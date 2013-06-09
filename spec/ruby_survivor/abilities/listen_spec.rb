require 'spec_helper'

describe RubySurvivor::Abilities::Listen do
  before(:each) do
    @floor = RubySurvivor::Floor.new
    @floor.width = 2
    @floor.height = 3
    @survivor = RubySurvivor::Units::Survivor.new
    @floor.add(@survivor, 0, 0)
    @listen = RubySurvivor::Abilities::Listen.new(@survivor)
  end
  
  it "should return an array of spaces which have units on them besides main unit" do
    @floor.add(RubySurvivor::Units::Base.new, 0, 1)
    @listen.perform.should have(1).record
  end
end
