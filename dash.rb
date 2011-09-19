require 'rubygems'
require 'libs/dashboard'
require 'libs/frontend/server'
require 'libs/comms/server'
require 'libs/processes/server'

@dashboard = Dash::Dashboard.new

frontend = Thread.new {Dash::FrontendServer.run(@dashboard)}
comms = Thread.new {Dash::CommsServer.run(@dashboard)}
#process = Thread.new {Dash::ProcessServer.run}

# Sinatra grabs all Ctrl-C requests, so wait for it to finish first, 
# then shut everything else down
frontend.join
comms.exit
#process.exit