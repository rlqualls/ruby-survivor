require 'spec_helper'

describe RubySurvivor::Abilities::Take do
  before(:each) do
    @taker = RubySurvivor::Units::Survivor.new
    @take = RubySurvivor::Abilities::Take.new(@taker)
    @item = RubySurvivor::Items::Medpack.new
  end
  
  it "should take the item" do
    @take.expects(:space).with(:forward).returns(stub(:item? => true))
    @take.expects(:target).with(:forward).returns(@item)
    @take.perform(:forward)
    @item.position.should be_nil
    @taker.has?(:medpack).should be_true
  end 

  it "should not take a non-item" do
    @take.expects(:space).with(:forward).returns(stub(:item? => false))
    @taker.expects(:say).with("tries to take something but it's not an item")
    @take.perform(:forward)
  end
end
