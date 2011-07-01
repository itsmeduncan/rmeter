require 'sinatra/base'
require 'haml'
require 'rmeter/version'
require 'time'

module Rmeter
  class Server < Sinatra::Base
    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/server/views"
    set :public, "#{dir}/server/public"
    set :static, true

    # get "/foo" do
    #   haml :foo
    # end
  end
end
