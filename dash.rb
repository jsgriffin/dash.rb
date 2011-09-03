require 'rubygems'
require 'libs/frontend/server'
require 'libs/comms/server'
require 'libs/processes/server'

frontend = Thread.new {Dash::FrontendServer.run!}
comms = Thread.new {Dash::CommsServer.run}
process = Thread.new {Dash::ProcessServer.run}

# Sinatra grabs all Ctrl-C requests, so wait for it to finish first, 
# then shut everything else down
frontend.join
comms.exit
process.exit