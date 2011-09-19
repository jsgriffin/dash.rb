require 'sinatra/base'
require 'erb'
require 'json'

class Dash
  class FrontendServer < Sinatra::Base
    dir = File.dirname(File.expand_path(__FILE__))
    @@dashboard = nil

    set :views,  "#{dir}/views"
    set :public, "#{dir}/public"
    set :static, true
    set :lock, true

    def self.run(dashboard)
      @@dashboard = dashboard
      self.run!
    end

    get '/' do
      puts @@dashboard.widgets
      erb(:index, {}, :widgets => @@dashboard.widgets.keys)
    end
    
    post '/register-widget' do
      puts params
      @@dashboard.registerWidget(JSON.parse(params[:widget]))
    end
  end
end

#puts widgets