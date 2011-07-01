#!/usr/bin/env ruby

require 'init'
require 'rmeter/server'

use Rack::ShowExceptions
run Rmeter::Server.new
