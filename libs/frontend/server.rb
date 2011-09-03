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
    
    get '/widgets/:widget/template' do
      widget_path = widgets[params[:widget]]
      template_file = File.open("#{widget_path}/public/template.ejs")
      template = template_file.read
      erb(:blank, {}, :output => template)
    end
  end
end

#puts widgets