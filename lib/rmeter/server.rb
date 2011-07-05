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
      aggregate = Rmeter::Aggregator.new( File.join(settings.data, '*') )

      haml :index, :locals => { :series => aggregate.time_by_url }
    end
  end
end
