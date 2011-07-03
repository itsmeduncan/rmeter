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
    set :data, "#{dir}/data"

    get "/" do
      files = Dir[File.join(settings.data, '*')]
      results = files.collect { |f| Rmeter::Parser.new(f).parse.to_json }

      haml :index
    end
  end
end
