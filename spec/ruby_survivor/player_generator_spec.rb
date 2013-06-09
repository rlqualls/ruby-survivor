require 'spec_helper'

describe RubySurvivor::PlayerGenerator do
  before(:each) do
    @level = RubySurvivor::Level.new(RubySurvivor::Profile.new, 15)
    @generator = RubySurvivor::PlayerGenerator.new(@level)
  end
  
  it "should know templates path" do
    @generator.templates_path.should == File.expand_path("../../../templates", __FILE__)
  end
end
