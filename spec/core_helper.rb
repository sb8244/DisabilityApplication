require_relative "../core/load"
require 'rspec/autorun'

Dir[File.dirname(__FILE__) + '/core/factories/*.rb'].each {|file| require file }

RSpec.configure do |config|
  config.order = "random"
end
