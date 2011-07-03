require 'rmeter/version'

require 'active_support/json'
require 'haml'
require 'sinatra/base'
require 'time'

module Rmeter
  class Server < Sinatra::Base
    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/server/views"
    set :public, "#{dir}/server/public"
    set :static, true
    set :data, File.expand_path("#{dir}/../../data")

    get "/" do
      files = Dir[File.join(settings.data, '*')]
      data = files.collect { |f| Rmeter::Parser.new(f).parse }.flatten
      results = data.map { |d| [ d[:timestamp].to_i * 1000, d[:time] ] }

      haml :index, :locals => { :results => results }
    end
  end
end
