require 'cucumber'
require 'rspec'

require File.dirname(__FILE__) + '/../../lib/ruby_survivor'

Before do
  RubySurvivor::Config.reset
end

After do
  FileUtils.rm_rf "areas/short"
end
