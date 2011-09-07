require 'libs/widgets/discovery'
require 'sinatra/base'
require 'erb'
require 'json'

class Dash
  class FrontendServer < Sinatra::Base
    widgets = Dash::WidgetDiscovery.discover
    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/views"
    set :public, "#{dir}/public"
    set :static, true
    set :lock, true

    get '/' do
      erb(:index, {}, :widgets => widgets.keys)
    end
  end
end

#puts widgets