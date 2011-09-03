require 'sinatra/base'
require 'erb'
require 'json'

class Dash
  class FrontendServer < Sinatra::Base
    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/views"
    set :public, "#{dir}/public"
    set :static, true
    set :lock, true

    get '/' do
      erb(:index, {})
    end
  end
end