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
    
    get '/:widget/:action' do
      if @@dashboard.loaded_widgets[params[:widget]].has_key?(:endpoint)
        puts "Sending #{params[:action]} to #{params[:widget]}"
        endpoint = @@dashboard.loaded_widgets[params[:widget]][:endpoint]
        endpoint.__send__ params[:action], params
      else
        puts "#{params[:widget]}::#{params[:action]} didn't exist"
      end
    end
  end
end

#puts widgets