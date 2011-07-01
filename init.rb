$LOAD_PATH.unshift ::File.expand_path(::File.dirname(__FILE__) + '/lib')

require 'bundler'
Bundler.require :default, ENV['RACK_ENV']

require 'rmeter'