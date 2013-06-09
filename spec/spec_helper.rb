require 'rubygems'
require 'rspec'
require File.dirname(__FILE__) + '/../lib/ruby_survivor'

# RSpec.configure do |config|
#   # config.mock_with :mocha
#   config.before(:each) do
#     RubySurvivor::Config.reset
#   end
# end

RSpec.configure do |config|
  config.mock_framework = :mocha
end
