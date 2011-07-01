#!/usr/bin/env ruby
require 'logger'

$LOAD_PATH.unshift ::File.expand_path(::File.dirname(__FILE__) + '/lib')
require 'rmeter/server'

use Rack::ShowExceptions
run Rmeter::Server.new
