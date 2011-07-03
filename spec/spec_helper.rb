ENV["RACK_ENV"] ||= 'test'

require 'init'
require 'rmeter/server'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  Rmeter::Server
end

