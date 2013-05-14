require 'rubygems'
require 'fft'

RSpec.configure do |config|
  config.order = 'random'
end

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end
